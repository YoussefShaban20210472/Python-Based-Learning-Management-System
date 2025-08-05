from flask import Blueprint

assignment_blueprint = Blueprint('assignment', __name__)

def demo(course_id=0,id=0):
    return 'demo'



# Instructor role

#   Add new assignment
assignment_blueprint.route('/',methods=['POST'])(demo)

#   Get assignment by id
assignment_blueprint.route('/<int:id>',methods=['GET'])(demo)

#   Get all assignments
assignment_blueprint.route('/all',methods=['GET'])(demo)

#   Update assignment by id
assignment_blueprint.route('/<int:id>',methods=['PUT'])(demo)

#   Delete assignment by id
assignment_blueprint.route('/<int:id>',methods=['DELETE'])(demo)


# Student role

#   Get assignment by id
assignment_blueprint.route('/<int:id>',methods=['GET'])(demo)

#   Get all assignments
assignment_blueprint.route('/all',methods=['GET'])(demo)

