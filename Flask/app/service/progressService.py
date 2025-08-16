from flask import  request
from app.Repository.Repository import  execute
import inspect



#  Get progress
def get_progress(course_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'course_id': course_id}
    return execute(inspect.currentframe().f_code.co_name, data)
