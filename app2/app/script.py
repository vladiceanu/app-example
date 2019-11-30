from flask import Flask, request, jsonify, json
from flask_log_request_id import RequestID, current_request_id

app = Flask(__name__)
RequestID(app)

@app.route("/health")
def get_health():
    return "healthy", 200

@app.route("/")
def get_home():
    return 200

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8080)