from flask import Blueprint, render_template, request, redirect, flash
from flask_login import login_required
from flask import current_app

patients_bp = Blueprint('patients_bp', __name__)

@patients_bp.route('/patients')
@login_required
def list_patients():
    mysql = current_app.extensions['mysql']
    cur = mysql.connection.cursor()
    cur.execute("""
    SELECT id, patient_number, first_name, last_name, birth_date,
           county, city, address, occupation, workplace,
           phone, email, cnp, marital_status, created_at
    FROM patients
""")

    patients = cur.fetchall()
    return render_template('patients.html', patients=patients)

@patients_bp.route('/patients/add', methods=['GET', 'POST'])
@login_required
def add_patient():
    mysql = current_app.extensions['mysql']
    if request.method == 'POST':
        number = request.form['number']
        first = request.form['first']
        last = request.form['last']
        cnp = request.form['cnp']
        birth = request.form['birth']

        cur = mysql.connection.cursor()
        cur.execute("""
            INSERT INTO patients (patient_number, first_name, last_name, birth_date, cnp)
            VALUES (%s, %s, %s, %s, %s)
        """, (number, first, last, birth, cnp))
        mysql.connection.commit()
        flash("Patient added successfully!")
        return redirect('/patients')

    return render_template('add_patient.html')
