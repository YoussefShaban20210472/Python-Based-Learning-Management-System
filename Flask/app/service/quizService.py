from flask import  request
from app.Repository.Repository import  execute
import inspect

#   Add new quiz
def add_quiz(course_id):
    data = request.get_json()
    data.update({'actor_id': getattr(request, "actor_id", None), 'course_id': course_id})
    return execute(inspect.currentframe().f_code.co_name, data)

#   Get quiz by id
def get_quiz_by_id(quiz_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'quiz_id': quiz_id}
    return execute(inspect.currentframe().f_code.co_name, data)

#   Get all quizzes
def get_all_quizzes(course_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'course_id': course_id}
    return execute(inspect.currentframe().f_code.co_name, data)

#   Update quiz by id
def update_quiz_by_id(quiz_id):
    data = request.get_json()
    data.update({'actor_id': getattr(request, "actor_id", None), 'quiz_id': quiz_id})
    return execute(inspect.currentframe().f_code.co_name, data)

#   Delete quiz by id
def delete_quiz_by_id(quiz_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'quiz_id': quiz_id}
    return execute(inspect.currentframe().f_code.co_name, data)





