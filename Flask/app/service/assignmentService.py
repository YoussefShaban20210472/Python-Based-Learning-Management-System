from flask import  request
from app.Repository.Repository import  execute
import inspect

#   Add new assignment
def add_assignment(course_id):
    data = request.get_json()
    data.update({'actor_id': getattr(request, "actor_id", None), 'course_id': course_id})
    return execute(inspect.currentframe().f_code.co_name, data)

#   Get assignment by id
def get_assignment_by_id(course_id,assignment_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'assignment_id': assignment_id}
    return execute(inspect.currentframe().f_code.co_name, data)

#   Get all assignments
def get_all_assignments(course_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'course_id': course_id}
    return execute(inspect.currentframe().f_code.co_name, data)

#   Update assignment by id
def update_assignment_by_id(course_id,assignment_id):
    data = request.get_json()
    data.update({'actor_id': getattr(request, "actor_id", None), 'assignment_id': assignment_id})
    return execute(inspect.currentframe().f_code.co_name, data)

#   Delete assignment by id
def delete_assignment_by_id(course_id,assignment_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'assignment_id': assignment_id}
    return execute(inspect.currentframe().f_code.co_name, data)





