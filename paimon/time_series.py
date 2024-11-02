import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.model_selection import TimeSeriesSplit, GridSearchCV, cross_val_score
from sklearn.linear_model import LinearRegression
from sklearn.ensemble import RandomForestRegressor, GradientBoostingRegressor
from statsmodels.tsa.stattools import acf
import warnings
from sklearn.metrics import root_mean_squared_error
import statsmodels.api as sm

# import pmdarima as pm
from statsmodels.tsa.arima.model import ARIMA
from scipy import stats
import pickle

from get_db import load_df, fetch_bahan_from_menu

warnings.filterwarnings("ignore")
main_df = pd.DataFrame()
restaurant_id = 0
models = {}
orders = {}
menu_count = 0
bahan_count = 0

def extract_df(rest_id):
    global main_df
    global restaurant_id
    global menu_count
    global bahan_count
    # print(load_df(rest_id))
    restaurant_id = rest_id
    main_df, menu_count, bahan_count = load_df(rest_id)

def create_lagged_features(df, features, max_lag):
    for col in features:
        for lag in range(1, max_lag + 1):
            df[f"{col}_lag{lag}"] = df[col].shift(lag)
    return df

def time_series_data():
    global main_df
    df_comp = main_df.copy()
    # print(df_comp)
    df_comp['date'] = pd.to_datetime(df_comp['date'])
    df_comp.set_index("date", inplace=True)
    df_comp = df_comp.asfreq('d')

    return df_comp

def find_best_lag(df_feature, target, max_lag):
    df = df_feature.copy()
    df = df[[target]]
    df = df.replace(0, np.nan)
    df = df.ffill().bfill()

    results = {}
    def _get_correlation_lag():
        # Calculate ACF
        acf_values = acf(df[target].dropna(), nlags=max_lag, alpha=0.05)
        # acf returns: (acf values, confidence intervals)
        acf_scores = acf_values[0]
        conf_intervals = acf_values[1]
        
        # print(acf_scores)
        # print(conf_intervals)
        # Find significant lags (outside confidence interval)
        significant_lags = []
        for lag in range(1, len(acf_scores)):
            if abs(acf_scores[lag]) > (conf_intervals[lag][1] - conf_intervals[lag][0])/2:
                significant_lags.append(lag)
        
        if not significant_lags:
            return 1  # Default to lag 1 if no significant lags found
        
        # Among significant lags, choose the one with highest absolute correlation
        lag_correlations = [(lag, abs(acf_scores[lag])) for lag in significant_lags]
        optimal_lag = max(lag_correlations, key=lambda x: x[1])[0]
        
        results['significant_lags'] = significant_lags
        results['lag_correlations'] = lag_correlations
        
        return optimal_lag
    
    def _get_predictive_lag():
        cv_scores = []
        tscv = TimeSeriesSplit(n_splits=5)
        
        for lag in range(1, max_lag + 1):
            rmse_scores = []
            feature_lagged = df[target].shift(lag)
            
            for train_idx, test_idx in tscv.split(df):
                X_train = feature_lagged.iloc[train_idx].dropna()
                y_train = df[target].iloc[train_idx].dropna()
                X_test = feature_lagged.iloc[test_idx].dropna()
                y_test = df[target].iloc[test_idx].dropna()
                
                common_idx = X_train.index.intersection(y_train.index)
                X_train = X_train[common_idx]
                y_train = y_train[common_idx]
                
                common_idx = X_test.index.intersection(y_test.index)
                X_test = X_test[common_idx]
                y_test = y_test[common_idx]
                
                if len(X_train) > 0 and len(X_test) > 0:
                    variance_X_train = np.var(X_train)
                    if variance_X_train != 0:
                        coefficient = np.cov(X_train, y_train)[0,1] / variance_X_train
                    else:
                        coefficient = 0
                    
                    intercept = y_train.mean() - coefficient * X_train.mean()
                    
                    y_pred = coefficient * X_test + intercept
                    rmse = root_mean_squared_error(y_test, y_pred)
                    rmse_scores.append(rmse)
            
            if rmse_scores:
                cv_scores.append(np.mean(rmse_scores))
        
        optimal_lag = np.argmin(cv_scores) + 1
        results['cv_scores'] = cv_scores
        
        return optimal_lag
    corr_lag = _get_correlation_lag()
    pred_lag = _get_predictive_lag()
    
    optimal_lag = corr_lag
    if corr_lag != pred_lag:
        # If they disagree, prefer the predictive lag if it's significant
        if results.get('significant_lags'):
            if pred_lag in results['significant_lags']:
                optimal_lag = pred_lag
            else:
                optimal_lag = corr_lag

    return optimal_lag

def train_model():
    global main_df
    global orders

    df = time_series_data()
    orders = {}
    def _fit_arima(p, d, q, data):
        try:
            model = ARIMA(data, order=(p, d, q))
            results = model.fit()
            return results.aic
        except:
            return np.inf
    
    for col in list(df.columns)[:-2]:
        col_df = df[[col]]
        col_df = col_df.replace(0, np.nan)
        col_df = col_df.ffill().bfill()
        p = range(0, 5)  
        d = range(0, 2)  
        q = range(0, 5)  

        best_order = None
        best_aic = np.inf
        for param in [(x[0], x[1], x[2]) for x in np.ndindex(len(p), len(d), len(q))]:
            aic = _fit_arima(param[0], param[1], param[2], col_df[col])
            if aic < best_aic:
                best_aic = aic
                best_order = param
    
        print(best_order)
        model = ARIMA(col_df[col], order=best_order)
        fitted = model.fit()
        orders[col] = best_order
        with open(f'saved_models/arima_model_{restaurant_id}_{col}.pkl', 'wb') as f:
            pickle.dump(fitted, f)
    with open(f'saved_models/arima_model_{restaurant_id}_{col}.pkl', 'wb') as f:
        pickle.dump(fitted, f)

def predict_model():
    global main_df
    global restaurant_id
    global menu_count
    global models
    global bahan_count
    df = time_series_data()
    prediksi = {"menu": {},
                "bahan": {}}
    models = {}
    menu = {}
    for idx, col in enumerate(list(df.columns)[:-2]):
        with open(f'saved_models/arima_model_{restaurant_id}_{col}.pkl', 'rb') as f:
            models[col] = pickle.load(f)
        forecast_steps = 3
        forecast = models[col].get_forecast(steps=forecast_steps)
        forecast_index = pd.date_range(start=df.index[-1] + pd.Timedelta(days=1), periods=forecast_steps)

        # Get predicted mean and confidence intervals
        predicted_mean = forecast.predicted_mean
        int_mean = [round(num) for num in list(predicted_mean)]

        # Create a DataFrame for better visualization
        if(idx < menu_count):
            prediksi["menu"][col] = {"predicted_values":int_mean,
                        "date": forecast_index.strftime('%Y-%m-%d').tolist()}
            menu[col] = int_mean
        
        
    result = fetch_bahan_from_menu(menu, restaurant_id)
    date = {"date": forecast_index.strftime('%Y-%m-%d').tolist()}
    
    for idx, col in enumerate(list(df.columns)[:-2]):
        lwr_col = col.lower()
        if(idx < menu_count):
            prediksi['menu'][lwr_col] = result[col]
        else:
            prediksi['bahan'][lwr_col] = result[col]

    print(prediksi)
    return date | prediksi

def visualize():
    global restaurant_id
    global menu_count
    global bahan_count
    global models
    global orders
    df = time_series_data()

    train_size = int(len(df) * 0.8) 
    train, test = df[:train_size], df[train_size:]

    print(train)
    for key, value in orders.items():
        print(key)
        print(value)
        model = ARIMA(train[key], order=value)  # Example order, adjust as needed
        model_fit = model.fit()
        
        # Step 3: Forecast on the test set
        forecast_steps = len(test)
        forecast = model_fit.forecast(steps=forecast_steps)
        print(forecast)

        # Step 4: Visualize the results
        plt.figure(figsize=(12, 6))
        plt.plot(train[key], label="Training Data")
        plt.plot(test[key], label="Test Data", color='orange')
        plt.plot(test[key].index, forecast, label="Forecast", color='green')
        plt.legend()
        plt.xlabel('Date')
        plt.ylabel('Values')
        plt.title('ARIMA Model Forecast For ' + key)
        plt.show()

        # Step 5: Evaluate the Model Performance
        rmse = np.sqrt(root_mean_squared_error(test[key], forecast))
        print(f'Root Mean Squared Error (RMSE): {rmse}')

        

# extract_df(1000)
# train_model()
# predict_model()
# visualize()