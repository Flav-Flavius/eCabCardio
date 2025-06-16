from flask import Blueprint, render_template, request, redirect, url_for, flash, current_app
from flask_login import login_required
from datetime import datetime

patients_bp = Blueprint('patients_bp', __name__)

# ---------------- LISTARE PACIENȚI -------------------
@patients_bp.route('/patients')
@login_required
def list_patients():
    mysql = current_app.extensions['mysql']
    cur = mysql.connection.cursor()

    search_field = request.args.get('criteria', 'first_name')
    search_value = request.args.get('search', '')
    page = int(request.args.get('page', 1))
    per_page = 10
    offset = (page - 1) * per_page

    allowed_fields = ['first_name', 'last_name', 'cnp', 'patient_number']
    if search_field not in allowed_fields:
        search_field = 'first_name'

    if search_value:
        query = f"SELECT * FROM patients WHERE {search_field} LIKE %s ORDER BY id DESC LIMIT %s OFFSET %s"
        cur.execute(query, (f"%{search_value}%", per_page, offset))
        patients = cur.fetchall()

        count_query = f"SELECT COUNT(*) FROM patients WHERE {search_field} LIKE %s"
        cur.execute(count_query, (f"%{search_value}%",))
        total_count = cur.fetchone()[0]
    else:
        cur.execute("SELECT * FROM patients ORDER BY id DESC LIMIT %s OFFSET %s", (per_page, offset))
        patients = cur.fetchall()

        cur.execute("SELECT COUNT(*) FROM patients")
        total_count = cur.fetchone()[0]

    total_pages = (total_count + per_page - 1) // per_page

    return render_template('patients.html',
                           patients=patients,
                           current_page=page,
                           total_pages=total_pages,
                           total_count=total_count,
                           search_field=search_field,
                           search_value=search_value)


# ---------------- ADAUGARE PACIENT -------------------
@patients_bp.route('/patients/add', methods=['GET', 'POST'])
@login_required
def add_patient():
    if request.method == 'POST':
        required_fields = ['number', 'first', 'last', 'birth', 'cnp']
        for field in required_fields:
            if not request.form.get(field):
                flash(f"The field '{field}' is required.", 'danger')
                return render_template('add_patient.html')

        data = (
            request.form['number'],
            request.form['first'],
            request.form['last'],
            request.form['birth'],
            request.form.get('county'),
            request.form.get('city'),
            request.form.get('address'),
            request.form.get('occupation'),
            request.form.get('workplace'),
            request.form.get('phone'),
            request.form.get('email'),
            request.form['cnp'],
            request.form.get('marital_status'),
            datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        )

        mysql = current_app.extensions['mysql']
        cur = mysql.connection.cursor()
        cur.execute("""
            INSERT INTO patients (
                patient_number, first_name, last_name, birth_date, county,
                city, address, occupation, workplace, phone, email,
                cnp, marital_status, created_at
            ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """, data)
        mysql.connection.commit()

        flash("Patient added successfully!", "success")
        return redirect(url_for('patients_bp.list_patients'))

    return render_template('add_patient.html')


# ---------------- EDITARE PACIENT -------------------
@patients_bp.route('/patients/edit/<int:patient_id>', methods=['GET', 'POST'])
@login_required
def edit_patient(patient_id):
    mysql = current_app.extensions['mysql']
    cur = mysql.connection.cursor()

    if request.method == 'POST':
        data = (
            request.form['number'],
            request.form['first'],
            request.form['last'],
            request.form['birth'],
            request.form.get('county'),
            request.form.get('city'),
            request.form.get('address'),
            request.form.get('occupation'),
            request.form.get('workplace'),
            request.form.get('phone'),
            request.form.get('email'),
            request.form['cnp'],
            request.form.get('marital_status'),
            patient_id
        )

        cur.execute("""
            UPDATE patients SET
                patient_number=%s, first_name=%s, last_name=%s, birth_date=%s,
                county=%s, city=%s, address=%s, occupation=%s, workplace=%s,
                phone=%s, email=%s, cnp=%s, marital_status=%s
            WHERE id=%s
        """, data)
        mysql.connection.commit()

        flash("Patient updated successfully!", "success")
        return redirect(url_for('patients_bp.list_patients'))

    cur.execute("SELECT * FROM patients WHERE id = %s", (patient_id,))
    patient = cur.fetchone()
    return render_template('edit_patient.html', patient=patient)


# ---------------- ȘTERGERE PACIENT -------------------
@patients_bp.route('/patients/delete/<int:patient_id>', methods=['POST'])
@login_required
def delete_patient(patient_id):
    mysql = current_app.extensions['mysql']
    cur = mysql.connection.cursor()

    cur.execute("DELETE FROM patients WHERE id = %s", (patient_id,))
    mysql.connection.commit()

    flash("Patient deleted successfully!", "success")
    return redirect(url_for('patients_bp.list_patients'))
