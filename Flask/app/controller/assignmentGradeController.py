from flask import Blueprint

assignment_grade_blueprint = Blueprint('assignment_grade', __name__)

def demo(course_id=0,assignment_id=0,submission_id=0):
    return 'demo'


# Instructor role

#   Add assignment grade
assignment_grade_blueprint.route('/<int:submission_id>/grade',methods=['POST'])(demo)

#   Get assignment grade by id
assignment_grade_blueprint.route('/<int:submission_id>/grade',methods=['GET'])(demo)

#   Get assignment grades
assignment_grade_blueprint.route('/all/grade',methods=['GET'])(demo)

#   Update assignment grade by id
assignment_grade_blueprint.route('/<int:submission_id>/grade',methods=['PUT'])(demo)

#   Delete assignment grade by id
assignment_grade_blueprint.route('/<int:submission_id>/grade',methods=['DELETE'])(demo)


# Student role

#   Get assignment grade by id
assignment_grade_blueprint.route('/grade',methods=['GET'])(demo)


