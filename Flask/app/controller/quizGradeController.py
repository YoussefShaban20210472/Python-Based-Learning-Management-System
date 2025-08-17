from flask import Blueprint
from app.service.quizGradeService import *

quiz_grade_blueprint = Blueprint('quiz_grade', __name__)



# Instructor role

#   Get quiz grade by id
quiz_grade_blueprint.route('/attempt/<int:id>/grade',methods=['GET'])(get_quiz_attempt_grade)

#   Get quiz grades
quiz_grade_blueprint.route('/attempt/all/grade',methods=['GET'])(get_quizzes_attempts_grades)



# Student role

#   Get quiz grade by using authenticated student
quiz_grade_blueprint.route('/attempt/grade',methods=['GET'])(get_my_quiz_attempt_grade)


