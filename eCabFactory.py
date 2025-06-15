from flask import Flask
from flask_mysqldb import MySQL
from flask_login import LoginManager
from utils.auth_helper import User

mysql = MySQL()
login_manager = LoginManager()

def create_app():
    app = Flask(__name__)
    app.config.from_pyfile('config.py')

    mysql.init_app(app)
    login_manager.init_app(app)
    login_manager.login_view = 'login'

    @login_manager.user_loader
    def load_user(user_id):
        cur = mysql.connection.cursor()
        cur.execute("SELECT id, username FROM users WHERE id = %s", (user_id,))
        user = cur.fetchone()
        if user:
            return User(user[0], user[1])
        return None

    from routes.auth import auth_bp
    from routes.dashboard import dashboard_bp

    app.register_blueprint(auth_bp)
    app.register_blueprint(dashboard_bp)

    return app
