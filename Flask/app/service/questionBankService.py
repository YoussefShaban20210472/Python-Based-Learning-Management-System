from flask import  request
from app.Repository.Repository import  execute
import inspect

#   Add new question bank
def add_bank_question(course_id):
    data = request.get_json()
    data.update({'actor_id': getattr(request, "actor_id", None), 'course_id': course_id})
    return execute(inspect.currentframe().f_code.co_name, data)

#   Get question bank by id
def get_bank_question_by_id(question_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'question_id': question_id}
    return execute(inspect.currentframe().f_code.co_name, data)

#   Get all questions bank
def get_bank_questions(course_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'course_id': course_id}
    return execute(inspect.currentframe().f_code.co_name, data)

#   Update question bank by id
def update_bank_question_by_id(question_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'question_id': question_id}
    return execute(inspect.currentframe().f_code.co_name, data)


#   Delete question bank by id
def delete_bank_question_by_id(question_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'question_id': question_id}
    return execute(inspect.currentframe().f_code.co_name, data)
