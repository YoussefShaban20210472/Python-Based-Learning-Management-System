from flask import Blueprint

enrollment_blueprint = Blueprint('enrollment', __name__)

def demo(course_id=0, id=0):
    return 'demo'


# Instructor role

#   Get all enrollments
enrollment_blueprint.route('/all',methods=['GET'])(demo)

#   Get enrollment by id
enrollment_blueprint.route('/<int:id>',methods=['GET'])(demo)

#   Confirm enrollment by id
enrollment_blueprint.route('/<int:id>',methods=['PUT'])(demo)



# Student role

#   Add new enrollment
enrollment_blueprint.route('/',methods=['POST'])(demo)

#   Get enrollment by using authenticated student
enrollment_blueprint.route('/',methods=['GET'])(demo)

#   Delete enrollment by using authenticated student
enrollment_blueprint.route('/',methods=['DELETE'])(demo)

