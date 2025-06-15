from flask import Blueprint, render_template, request, redirect, flash
from flask_login import login_user, logout_user, login_required, current_user
from eCabFactory import mysql
from utils.auth_helper import User

auth_bp = Blueprint('auth_bp', __name__)

@auth_bp.route('/')
def home_redirect():
    if current_user.is_authenticated:
        return redirect('/dashboard')
    return redirect('/login')

@auth_bp.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        cur = mysql.connection.cursor()
        cur.execute("SELECT id, username, password FROM users WHERE username = %s", (username,))
        user = cur.fetchone()
        if user and password == user[2]:
            login_user(User(user[0], user[1]))
            return redirect('/dashboard')
        else:
            flash("Invalid username or password.")
    return render_template('login.html')

@auth_bp.route('/logout')
@login_required
def logout():
    logout_user()
    return redirect('/login')
