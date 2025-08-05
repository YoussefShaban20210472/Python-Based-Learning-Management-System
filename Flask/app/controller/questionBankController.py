from flask import Blueprint

question_bank_blueprint = Blueprint('question_bank', __name__)

def demo(course_id=0,id=0):
    return 'demo'



# Instructor role

#   Add new question bank
question_bank_blueprint.route('/',methods=['POST'])(demo)

#   Get question bank by id
question_bank_blueprint.route('/<int:id>',methods=['GET'])(demo)

#   Get all questions bank
question_bank_blueprint.route('/all',methods=['GET'])(demo)

#   Update question bank by id
question_bank_blueprint.route('/<int:id>',methods=['PUT'])(demo)

#   Delete question bank by id
question_bank_blueprint.route('/<int:id>',methods=['DELETE'])(demo)
