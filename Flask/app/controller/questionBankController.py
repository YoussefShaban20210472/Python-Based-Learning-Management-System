from flask import Blueprint
from app.service.questionBankService import *

question_bank_blueprint = Blueprint('question_bank', __name__)



# Instructor role

#   Add new question bank
question_bank_blueprint.route('/',methods=['POST'])(add_bank_question)

#   Get question bank by id
question_bank_blueprint.route('/<int:id>',methods=['GET'])(get_bank_question_by_id)

#   Get all questions bank
question_bank_blueprint.route('/all',methods=['GET'])(get_bank_questions)

#   Update question bank by id
question_bank_blueprint.route('/<int:id>',methods=['PUT'])(update_bank_question_by_id)

#   Delete question bank by id
question_bank_blueprint.route('/<int:id>',methods=['DELETE'])(delete_bank_question_by_id)
