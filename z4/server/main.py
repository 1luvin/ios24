from flask import Flask, jsonify

app = Flask(__name__)

categories = [
    {"id": 1, "title": "Electronics"},
    {"id": 2, "title": "Books"}
]

products = [
    {"id": 1, "title": "Smartphone", "desc": "The smartest smartphone", "price": 799.99, "category_id": 1},
    {"id": 2, "title": "Laptop", "desc": "The fastest laptop", "price": 1399.99, "category_id": 1},
    {"id": 3, "title": "Fiction Book", "desc": "The most interesting book", "price": 14.99, "category_id": 2}
]


@app.route('/categories', methods=['GET'])
def get_categories():
    return jsonify(categories)


@app.route('/products', methods=['GET'])
def get_products():
    return jsonify(products)


if __name__ == '__main__':
    app.run(host="0.0.0.0", port=8000)
