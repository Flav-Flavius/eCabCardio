from flask import Blueprint, render_template
from flask_login import login_required, current_user

dashboard_bp = Blueprint('dashboard_bp', __name__)

@dashboard_bp.route('/dashboard')
@login_required
def dashboard():
    # Hardcoded pentru test – în viitor, o să iei din DB
    role = 'medic'  # sau 'admin', temporar pentru afișare corectă

    return render_template('dashboard.html', user=current_user, role=role)
