from flask import Flask
import json
import urllib3
import os

UPSTREAM_URL = os.environ.get("UPSTREAM_URL")
UPSTREAM_PORT = os.environ.get("UPSTREAM_PORT")

if UPSTREAM_URL is None or UPSTREAM_PORT is None:
    print("Make sure you set environment variables \
            UPSTREAM_URL and UPSTREAM_PORT")
    exit(1)

app = Flask(__name__)

@app.route("/health")
def get_health():
    return "healthy", 200

@app.route("/")
def get_home():
    try:
        http = urllib3.PoolManager()
        url = 'http://{}:{}/'.format(UPSTREAM_URL,UPSTREAM_PORT)
        r = http.request('GET', url)
        message = json.loads(r.data.decode('utf-8'))
        return ''.join(reversed(message["message"])), 200
    except Exception as e:
        return {"error": e}

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8080)