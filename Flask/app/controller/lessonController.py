from flask import Blueprint

lesson_blueprint = Blueprint('lesson', __name__)

def demo(course_id=0,id=0):
    return 'demo'



# Instructor role

#   Add new lesson
lesson_blueprint.route('/',methods=['POST'])(demo)

#   Get lesson by id
lesson_blueprint.route('/<int:id>',methods=['GET'])(demo)

#   Get all lessons
lesson_blueprint.route('/all',methods=['GET'])(demo)

#   Update lesson by id
lesson_blueprint.route('/<int:id>',methods=['PUT'])(demo)

#   Delete lesson by id
lesson_blueprint.route('/<int:id>',methods=['DELETE'])(demo)


# Student role

#   Get lesson by id
lesson_blueprint.route('/<int:id>',methods=['GET'])(demo)

#   Get all lessons
lesson_blueprint.route('/all',methods=['GET'])(demo)

