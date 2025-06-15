from flask import Blueprint, render_template, current_app
from flask_login import login_required, current_user

from flask import Blueprint, render_template
from flask_login import login_required, current_user
from flask import current_app

dashboard_bp = Blueprint('dashboard_bp', __name__)

@dashboard_bp.route('/dashboard')
@login_required
def dashboard():
    mysql = current_app.extensions['mysql']
    cur = mysql.connection.cursor()

    # Obține rolul user-ului conectat
    cur.execute("""
        SELECT r.name
        FROM users u
        JOIN user_roles ur ON u.id = ur.user_id
        JOIN roles r ON ur.role_id = r.id
        WHERE u.id = %s
    """, (current_user.id,))
    role = cur.fetchone()[0] if cur.rowcount > 0 else 'unknown'

    return render_template('dashboard.html', user=current_user, role=role)

