from flask import Blueprint
from app.service.quizBankService import *

quiz_bank_blueprint = Blueprint('quiz_bank', __name__)

# Instructor role

#  add quiz bank
quiz_bank_blueprint.route('/quiz',methods=['POST'])(add_quiz_from_bank)
