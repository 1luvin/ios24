from flask import Flask, request, jsonify
from werkzeug.security import generate_password_hash, check_password_hash
import requests

app = Flask(__name__)

users = {}


def get_password_hash(password):
    return generate_password_hash(password)


def verify_password(plain_password, hashed_password):
    return check_password_hash(hashed_password, plain_password)


@app.route('/register', methods=['POST'])
def register():
    data = request.json
    username = data.get('username')
    password = data.get('password')

    if not username or not password:
        return jsonify({'error': 'Missing username or password'}), 400

    if username in users:
        return jsonify({"error": "Username already exists"}), 400

    hashed_password = get_password_hash(password)
    users[username] = hashed_password
    return jsonify({"message": "User registered successfully"})


@app.route('/login', methods=['POST'])
def login():
    data = request.json
    username = data.get('username')
    password = data.get('password')

    hashed_password = users.get(username)
    if not hashed_password or not verify_password(password, hashed_password):
        return jsonify({"error": "Invalid username or password"}), 400

    return jsonify({"access_token": username, "token_type": "bearer"})


@app.route('/oauth/google', methods=['POST'])
def oauth_google():
    token = request.json.get('token')
    google_api_url = "https://www.googleapis.com/oauth2/v3/tokeninfo"
    response = requests.get(google_api_url, params={"id_token": token})
    if response.status_code != 200:
        return jsonify({"error": "Invalid Google token"}), 400

    user_info = response.json()
    return jsonify({"message": "Google token verified", "user_info": user_info})


# @app.route('/oauth/github', methods=['POST'])
# def oauth_github():
#     token = request.json.get('token')
#     github_api_url = "https://api.github.com/user"
#     headers = {"Authorization": f"Bearer {token}"}
#     response = requests.get(github_api_url, headers=headers)
#     if response.status_code != 200:
#         return jsonify({"error": "Invalid Github token"}), 400
#
#     user_info = response.json()
#     print(user_info)
#     return jsonify({"message": "Github token verified", "user_info": user_info})


if __name__ == '__main__':
    app.run(host="0.0.0.0", port=8000, debug=True)
