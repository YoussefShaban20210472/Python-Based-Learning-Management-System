from flask import Blueprint
from app.service.quizAttemptService import *

quiz_attempt_blueprint = Blueprint('quiz_attempt', __name__)



# Instructor / Student role

#  Add quiz attempt
quiz_attempt_blueprint.route('/',methods=['POST'])(add_quiz_attempt)
