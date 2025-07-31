from flask import Flask
from app.controller.userController import user_blueprint

def create_app():
    app = Flask(__name__)
    app.register_blueprint(user_blueprint, url_prefix='/user')
    return app
