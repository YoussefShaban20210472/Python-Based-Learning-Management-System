from flask import  request
from app.Repository.Repository import  execute
import inspect

#  Add quiz attempt
def add_quiz_attempt(quiz_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'quiz_id': quiz_id}
    return execute(inspect.currentframe().f_code.co_name, data)
