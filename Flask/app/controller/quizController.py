from flask import Blueprint

quiz_blueprint = Blueprint('quiz', __name__)

def demo(course_id=0,id=0):
    return 'demo'



# Instructor role

#   Add new quiz
quiz_blueprint.route('/',methods=['POST'])(demo)

#   Get quiz by id
quiz_blueprint.route('/<int:id>',methods=['GET'])(demo)

#   Get all quizzes
quiz_blueprint.route('/all',methods=['GET'])(demo)

#   Update quiz by id
quiz_blueprint.route('/<int:id>',methods=['PUT'])(demo)

#   Delete quiz by id
quiz_blueprint.route('/<int:id>',methods=['DELETE'])(demo)


# Student role

#   Get quiz by id
quiz_blueprint.route('/<int:id>',methods=['GET'])(demo)

#   Get all quizzes
quiz_blueprint.route('/all',methods=['GET'])(demo)

