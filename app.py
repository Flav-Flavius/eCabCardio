from flask import Flask
from flask_mysqldb import MySQL
from flask_login import LoginManager


app = Flask(__name__)
app.config.from_pyfile('config.py')

# Inițializare MySQL
mysql = MySQL(app)

# Inițializare Flask-Login
login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = 'login'  # redirect dacă utilizatorul nu e logat

# Funcția care încarcă utilizatorul autentificat
@login_manager.user_loader
def load_user(user_id):
    return get_user_by_id(user_id)

# Importă toate rutele aplicației
from routes import *

# Rulează serverul Flask
if __name__ == '__main__':
    app.run(debug=True)

