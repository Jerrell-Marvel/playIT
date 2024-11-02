import pandas as pd
import numpy as np
import pickle
from sklearn.model_selection import TimeSeriesSplit, cross_val_score
from sklearn.preprocessing import StandardScaler
from sklearn.feature_selection import mutual_info_regression
from sklearn.linear_model import Lasso, Ridge, ElasticNet
from sklearn.ensemble import RandomForestRegressor, GradientBoostingRegressor
from sklearn.svm import SVR
from sklearn.metrics import root_mean_squared_error
import matplotlib.pyplot as plt
from get_db import fetch_bahan_from_menu, load_df
import warnings
warnings.filterwarnings('ignore')

main_df = pd.DataFrame()
selected_features = []
restaurant_id = 0
menu_count = 0
bahan_count = 0
target = ""

def extract_df(rest_id):
    global main_df
    global restaurant_id
    global menu_count
    global bahan_count

    restaurant_id = rest_id
    main_df, menu_count, bahan_count = load_df(rest_id)



def preprocess(X=None):
    global main_df
    global menu_count
    global target

    # print(main_df)
    if(X is None):
        X = main_df.copy()
    
    # print(X)
    df = X.copy()
    # print(df)
    if('date' in df.columns):
        df['date'] = pd.to_datetime(df['date'])
        df.set_index('date', inplace=True)
        target = 'food_waste_in_gr'
    # if target in df.columns:

    #     menu_cols = df.iloc[:,:menu_count]
    #     ingredient_cols = df.iloc[:,menu_count:-1]
    #     df['total_orders'] = menu_cols.sum(axis=1)
    #     df['total_ingredients'] = ingredient_cols.sum(axis=1)
    #     df['ingredients_per_order'] = df['total_ingredients'] / df['total_orders'].replace(0, 1)
    #     df['revenue_per_order'] = df['total_harga'] / df['total_orders'].replace(0, 1)
    #     df['day_of_week'] = df.index.dayofweek
    #     df['month'] = df.index.month

    #     df['day_of_week'] = df.index.dayofweek
    #     df['month'] = df.index.month
        
    #     # Create rolling features (with small window due to limited data)
    #     for col in list(df.columns[:menu_count]) + list(df.columns[menu_count:-1]):
    #         # print(col)
    #         df[f'{col}_rolling_mean_2'] = df[col].rolling(window=2, min_periods=1).mean()
        
    #     # Store processed features
    #     processed_df = df

    #     return processed_df
    # else:
    #     menu_cols = df.iloc[:,:menu_count]
    #     ingredient_cols = df.iloc[:,menu_count:-1]
    #     df['total_orders'] = menu_cols.sum(axis=1)
    #     df['total_ingredients'] = ingredient_cols.sum(axis=1)
    #     df['ingredients_per_order'] = df['total_ingredients'] / df['total_orders'].replace(0, 1)
    #     df['revenue_per_order'] = df['total_harga'] / df['total_orders'].replace(0, 1)
    #     df['day_of_week'] = df.index.dayofweek
    #     df['month'] = df.index.month

    #     df['day_of_week'] = df.index.dayofweek
    #     df['month'] = df.index.month
        
    #     # Create rolling features (with small window due to limited data)
    #     for col in list(df.columns[:menu_count]) + list(df.columns[menu_count::]):
    #         # print(col)
    #         df[f'{col}_rolling_mean_2'] = df[col].rolling(window=2, min_periods=1).mean()
        
    #     # Store processed features
    #     processed_df = df

    return df
def evaluate_models(X, y):
    """
    Evaluate multiple models using time series cross-validation
    """
    models = {
        'lasso': Lasso(random_state=42),
        'ridge': Ridge(random_state=42),
        'elastic_net': ElasticNet(random_state=42),
        'rf': RandomForestRegressor(n_estimators=100, random_state=42),
        'gbm': GradientBoostingRegressor(n_estimators=100, random_state=42),
        'svr': SVR(kernel='rbf')
    }
    
    tscv = TimeSeriesSplit(n_splits=3)
    results = {}
    
    for name, model in models.items():
        scores = cross_val_score(model, X, y, 
                            cv=tscv, 
                            scoring='neg_root_mean_squared_error')
        results[name] = {
            'rmse': -scores.mean(),
            'std': scores.std()
        }
    
    return results


def select_features(X, y):
    """
    Select important features using multiple methods
    """
    # Remove constant and highly correlated features
    # print(X)
    X = X.loc[:, X.std() > 0]
    # print(X)
    
    # Calculate feature importance using multiple methods
    importance_scores = {}
    
    # Method 1: Mutual Information
    mi_scores = mutual_info_regression(X, y)
    importance_scores['mi'] = dict(zip(X.columns, mi_scores))
    
    # Method 2: Lasso coefficients
    lasso = Lasso(alpha=0.01, random_state=42)
    lasso.fit(X, y)
    importance_scores['lasso'] = dict(zip(X.columns, np.abs(lasso.coef_)))
    
    # Method 3: Random Forest importance
    rf = RandomForestRegressor(n_estimators=100, random_state=42)
    rf.fit(X, y)
    importance_scores['rf'] = dict(zip(X.columns, rf.feature_importances_))
    
    # Combine importance scores
    combined_importance = {}
    for col in X.columns:
        scores = [
            importance_scores['mi'][col],
            importance_scores['lasso'][col],
            importance_scores['rf'][col]
        ]
        combined_importance[col] = np.mean(scores)
    
    n_features = min(15, len(X.columns))  # Limit to top 15 features
    # print(n_features)
    selected_features = sorted(combined_importance.items(), 
                            key=lambda x: x[1], 
                            reverse=True)[:n_features]
    
    return [feat[0] for feat in selected_features]

def save_best_model(X, y, model_type="rf"):
    """
    Train the best model on all data
    """
    models = {
        'lasso': Lasso(random_state=42),
        'ridge': Ridge(random_state=42),
        'elastic_net': ElasticNet(random_state=42),
        'rf': RandomForestRegressor(n_estimators=100, random_state=42),
        'gbm': GradientBoostingRegressor(n_estimators=100, random_state=42),
        'svr': SVR(kernel='rbf')
    }
    
    model = models[model_type]
    # print(X)
    # print(y)
    fitted = model.fit(X, y)
    
    with open(f'saved_models/food_waste_model_{restaurant_id}.pkl', 'wb') as f:
        pickle.dump({'model': fitted, 'features': selected_features}, f)
    

def train_model():
    global selected_features
    df = preprocess()
    y = df[target]
    X = df.drop([target], axis=1)

    selected_features = select_features(X, y)
    X_selected = X[selected_features]

    scaler = StandardScaler()
    X_scaled = scaler.fit_transform(X_selected)
    X_scaled = pd.DataFrame(X_scaled, columns=X_selected.columns, index=X_selected.index)
    
    # Evaluate models
    model_results = evaluate_models(X_scaled, y)
    # find best model
    best_model = min(model_results.items(), key=lambda x: x[1]['rmse'])[0]
    save_best_model(X_scaled, y, best_model)

def predict_model(bahan,restaurant_id):
    # print(restaurant_id)
    global main_df
    extract_df(restaurant_id)
    train_model()
    X_predict = pd.DataFrame(fetch_bahan_from_menu(bahan, restaurant_id))
    # print(X_predict)

    with open(f'saved_models/food_waste_model_{restaurant_id}.pkl', 'rb') as f:
        saved_data = pickle.load(f)
        picked_model = saved_data['model']
        selected_features = saved_data['features']

    X_predict = X_predict.reindex(columns=selected_features)
    X_predict = preprocess(X_predict)[selected_features]
    # print(X_predict)
    scaler = StandardScaler()
    X_scaled = scaler.fit_transform(X_predict)
    # print(X_scaled)
    X_scaled = pd.DataFrame(X_scaled, columns=X_predict.columns, index=X_predict.index)
    result = picked_model.predict(X_scaled)

    return list(result)

def visualize():
    global restaurant_id
    global main_df

    df = main_df.copy()
    train_size = int(len(df) * 0.8) 
    train, test = df[:train_size], df[train_size:]

    print(train)

    X_train = train.drop([target], axis=1)
    y_train = train[target]

    y_test = test[target]

    results =  evaluate_models(X_train, y_train)
    best_model = min(results.items(), key=lambda x: x[1]['rmse'])[0]
    models = {
        'lasso': Lasso(random_state=42),
        'ridge': Ridge(random_state=42),
        'elastic_net': ElasticNet(random_state=42),
        'rf': RandomForestRegressor(n_estimators=100, random_state=42),
        'gbm': GradientBoostingRegressor(n_estimators=100, random_state=42),
        'svr': SVR(kernel='rbf')
    }
    
    model = models[best_model]
    # print(X)
    # print(y)
    fitted = model.fit(X_train, y_train)
    predicted = fitted.predict(y_test)
    plt.figure(figsize=(12, 6))
    plt.plot(train[target], label="Training Data")
    plt.plot(test[target], label="Test Data", color='orange')
    plt.plot(test[target].index, predicted, label="Forecast", color='green')
    plt.legend()
    plt.xlabel('Date')
    plt.ylabel('Values')
    plt.title(best_model + ' Model Forecast' )
    plt.show()

    # Step 5: Evaluate the Model Performance
    rmse = np.sqrt(root_mean_squared_error(test[target], predicted))
    print(f'Root Mean Squared Error (RMSE): {rmse}')

    
# train_model()

# test = main_df.copy()
# test = test.drop('food_waste_in_gr', axis=1).tail(1)

# print(predict_model(test))

# extract_df(1000)
# visualize()