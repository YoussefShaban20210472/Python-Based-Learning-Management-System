from flask import Blueprint

quiz_grade_blueprint = Blueprint('quiz_grade', __name__)

def demo(course_id=0,quiz_id=0,id=0):
    return 'demo'


# Instructor role

#   Get quiz grade by id
quiz_grade_blueprint.route('/attempt/<int:id>/grade',methods=['GET'])(demo)

#   Get quiz grades
quiz_grade_blueprint.route('/attempt/all/grade',methods=['GET'])(demo)



# Student role

#   Get quiz grade by using authenticated student
quiz_grade_blueprint.route('/attempt/grade',methods=['GET'])(demo)


