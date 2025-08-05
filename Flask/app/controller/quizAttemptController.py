from flask import Blueprint

quiz_attempt_blueprint = Blueprint('quiz_attempt', __name__)

def demo(course_id=0,quiz_id=0):
    return 'demo'



# Instructor / Student role

#  Add quiz attempt
quiz_attempt_blueprint.route('/',methods=['POST'])(demo)
