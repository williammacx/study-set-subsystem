from flask import Flask, request, render_template
from flask_cors import CORS, cross_origin

from database import get_db_connection
from functions.courses import get_courses
from functions.assignments import get_assignments, get_assignments_summary, update_assignment_status

app = Flask(__name__)
CORS(app)

@app.route("/courses", methods=["GET"])
@cross_origin()
def api_get_courses():
  return get_courses()

@app.route("/assignments", methods=["GET"])
@cross_origin()
def api_get_assignments():
  user_id = request.args.get('user_id')

  return get_assignments(user_id)

@app.route("/assignments/summary", methods=["GET"])
@cross_origin()
def api_get_assignments_summary():
  user_id = request.args.get('user_id')

  return get_assignments_summary(user_id)

@app.route("/assignments/<assignment_id>/status", methods=["PATCH"])
@cross_origin()
def api_get_assignment_status(assignment_id):
  payload = request.get_json()
  
  return update_assignment_status(assignment_id, payload)

@app.route("/studysets", methods=["GET"])
@cross_origin()
def api_get_all_studysets():
  cnx = get_db_connection()
  cursor = cnx.cursor()
  
  cursor.execute("""
    SELECT study_set.title, study_set.description, app_user.full_name, study_set.created_at 
    FROM study_set 
    LEFT JOIN app_user ON study_set.created_by = app_user.user_id
  """)
    
  study_sets = cursor.fetchall()
  print(f"Found {len(study_sets)} study sets")  # Debug print
  print(study_sets)  # Print the actual data

  cursor.close()

  return render_template('studyset.html', study_sets=study_sets)

@app.route("/health", methods=["GET"])
@cross_origin()
def api_health():
  return { "ok": True }

if __name__ == "__main__":
  app.run(debug=True)
