from flask import  request
from app.Repository.Repository import  execute
import inspect


#   Add new course
def add_course():
    data = request.get_json()
    data.update({'actor_id': getattr(request, "actor_id", None)})
    return execute(inspect.currentframe().f_code.co_name, data)

#   Get course by id
def get_course_by_id(id):
    data = request.get_json()
    data.update({'actor_id': getattr(request, "actor_id", None), 'course_id': id})
    return execute(inspect.currentframe().f_code.co_name, data)


def update_course_by_id(id):
    data = request.get_json()
    data.update({'actor_id': getattr(request, "actor_id", None), 'course_id': id})
    return execute(inspect.currentframe().f_code.co_name, data)


def delete_course_by_id(id):
    data = request.get_json()
    data.update({'actor_id': getattr(request, "actor_id", None), 'course_id': id})
    return execute(inspect.currentframe().f_code.co_name, data)



def get_all_courses():
    data = request.get_json()
    data.update({'actor_id': getattr(request, "actor_id", None), 'course_id': id})
    return execute(inspect.currentframe().f_code.co_name, data)





