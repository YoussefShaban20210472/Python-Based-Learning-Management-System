from flask import Blueprint

course_blueprint = Blueprint('course', __name__)

def demo(id =0):
    return 'demo'


# Instructor role

#   Add new course
course_blueprint.route('/',methods=['POST'])(demo)

#   Get course by id
course_blueprint.route('/<int:id>',methods=['GET'])(demo)

#   Update course by id
course_blueprint.route('/<int:id>',methods=['PUT'])(demo)

#   Delete course by id
course_blueprint.route('/<int:id>',methods=['DELETE'])(demo)


# Student role

#   Get all courses
course_blueprint.route('/all',methods=['GET'])(demo)

#   Get course by id
course_blueprint.route('/<int:id>',methods=['GET'])(demo)

