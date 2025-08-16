from flask import  request
from app.Repository.Repository import  execute
import inspect


#   Add new course
def add_course():
    data = request.get_json()
    data.update({'actor_id': getattr(request, "actor_id", None)})
    return execute(inspect.currentframe().f_code.co_name, data)

#   Get course by id
def get_course_by_id(course_id):
    data = {'actor_id': getattr(request, "actor_id", None), 'course_id': course_id}
    return execute(inspect.currentframe().f_code.co_name, data)

#   Update course by id
def update_course_by_id(course_id):
    data = request.get_json()
    data.update({'actor_id': getattr(request, "actor_id", None), 'course_id': course_id})
    return execute(inspect.currentframe().f_code.co_name, data)

#   Delete course by id
def delete_course_by_id(course_id):
    data = {'actor_id': getattr(request, "actor_id", None), 'course_id': course_id}
    return execute(inspect.currentframe().f_code.co_name, data)

#   Get all courses
def get_all_courses():
    data = {'actor_id': getattr(request, "actor_id", None)}
    return execute(inspect.currentframe().f_code.co_name, data)





