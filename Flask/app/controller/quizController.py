from flask import Blueprint
from app.service.quizService import *

quiz_blueprint = Blueprint('quiz', __name__)




# Instructor role

#   Add new quiz
quiz_blueprint.route('/',methods=['POST'])(add_quiz)

#   Get quiz by id
quiz_blueprint.route('/<int:id>',methods=['GET'])(get_quiz_by_id)

#   Get all quizzes
quiz_blueprint.route('/all',methods=['GET'])(get_all_quizzes)

#   Update quiz by id
quiz_blueprint.route('/<int:quiz_id>',methods=['PUT'])(update_quiz_by_id)

#   Delete quiz by id
quiz_blueprint.route('/<int:quiz_id>',methods=['DELETE'])(delete_quiz_by_id)


# Student role

#   Get quiz by id
quiz_blueprint.route('/<int:quiz_id>',methods=['GET'])(get_quiz_by_id)

#   Get all quizzes
quiz_blueprint.route('/all',methods=['GET'])(get_all_quizzes)

