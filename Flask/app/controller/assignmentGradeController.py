from flask import Blueprint
from app.service.assignmentGradeService import *
assignment_grade_blueprint = Blueprint('assignment_grade', __name__)


# Instructor role

#   Add assignment grade
assignment_grade_blueprint.route('/<int:submission_id>/grade',methods=['POST'])(add_submission_grade)

#   Get assignment grade by id
assignment_grade_blueprint.route('/<int:submission_id>/grade',methods=['GET'])(get_submission_grade_by_id)

#   Get all assignments grades
assignment_grade_blueprint.route('/all/grade',methods=['GET'])(get_all_submissions_grades)

#   Update assignment grade by id
assignment_grade_blueprint.route('/<int:submission_id>/grade',methods=['PUT'])(update_submission_grade_by_id)

#   Delete assignment grade by id
assignment_grade_blueprint.route('/<int:submission_id>/grade',methods=['DELETE'])(delete_submission_grade_by_id)


# Student role

#   Get assignment grade by id
assignment_grade_blueprint.route('/grade',methods=['GET'])(get_submission_grade_by_id)


