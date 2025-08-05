from flask import Blueprint

quiz_bank_blueprint = Blueprint('quiz_bank', __name__)

def demo(course_id=0):
    return 'demo'



# Instructor role

#  add quiz bank
quiz_bank_blueprint.route('/quiz',methods=['POST'])(demo)
