from flask import Flask, jsonify, request
import time_series as ts
import food_waste as fw

app = Flask(__name__)

@app.route('/api/test', methods=['GET'])
def testing():
    return jsonify({"message": "masuk bang!"})

@app.route('/api/train_ts', methods=['GET'])
def train_ts():
    restaurant_id = request.args.get('restaurant_id')
    print(restaurant_id)
    ts.extract_df(restaurant_id)
    ts.train_model()
    return(jsonify({"message": "selamat sukses"}))

@app.route('/api/predict_quantities', methods=['POST'])
def predict_quantities():
    data = request.get_json()
    restaurant_id = data.get("restaurant_id")

    if restaurant_id is None:
        return jsonify({"error": "Invalid input"}), 400
    
    ts.extract_df(restaurant_id)
    hasil = ts.predict_model()
    return jsonify(hasil)

@app.route('/api/train_fw', methods=['GET'])
def train_fw():
    restaurant_id = request.args.get('restaurant_id', type=int)
    fw.extract_df(restaurant_id)
    fw.train_model()
    return(jsonify({"message": "sukses bro"}))

@app.route('/api/predict_fw', methods=['POST'])
def predict_fw():
    data = request.get_json()
    restaurant_id = data.get("restaurant_id")
    bahan = data.get("menu")
    print(bahan)

    if restaurant_id is None:
        return jsonify({"error": "Invalid input"}), 400
    
    hasil = fw.predict_model(bahan, restaurant_id)
    return jsonify(hasil)


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=8080)
