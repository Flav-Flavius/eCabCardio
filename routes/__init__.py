from flask import render_template, redirect, request, Blueprint, flash
from flask_login import login_user, logout_user, UserMixin
from app import app, mysql

# Clasa User necesară pentru Flask-Login
class User(UserMixin):
    def __init__(self, id, username):
        self.id = id
        self.username = username

# Funcție folosită de login_manager.user_loader
def get_user_by_id(user_id):
    cur = mysql.connection.cursor()
    cur.execute("SELECT id, username FROM users WHERE id = %s", (user_id,))
    user = cur.fetchone()
    if user:
        return User(user[0], user[1])
    return None

# Rute principale
@app.route('/')
def index():
    return redirect('/login')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        cur = mysql.connection.cursor()
        cur.execute("SELECT id, username, password FROM users WHERE username = %s", (username,))
        user = cur.fetchone()

        if user and password == user[2]:  # simplu momentan, fără hash
            login_user(User(user[0], user[1]))
            return redirect('/')  # du-l la pagina principală
        else:
            flash("Utilizator sau parolă greșite!")

    return render_template('login.html')
