from flask import Flask, jsonify
import time
import os

app = Flask(__name__)
START_TIME = time.time()

@app.route('/')
def home():
    return "<h1>Salom Sanjar! GitHub Actions orqali Docker Hub'dan yuklandim!</h1>\n"

@app.route('/health')
def health():
    uptime = time.time() - START_TIME
    return jsonify({
        "status": "healthy",
        "service": "devops-practice-api",
        "uptime_seconds": round(uptime, 2)
    }), 200

@app.route('/info')
def info():
    return jsonify({
        "version": "1.1.0",
        "environment": os.getenv("APP_ENV", "production"),
        "author": "Sanjar Oktamov"
    }), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

