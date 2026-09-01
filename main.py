from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return "<h1>Salom Sanjar! GitHub Actions orqali Docker Hub'dan yuklandim!</h1>\n"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
