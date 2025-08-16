from flask import  request
from app.Repository.Repository import  execute
import inspect


#   Add new enrollment
def add_enrollment(course_id):
    data = request.get_json()
    data.update({'actor_id': getattr(request, "actor_id", None), 'course_id': course_id})
    return execute(inspect.currentframe().f_code.co_name, data)

#   Get all enrollments
def get_all_enrollments(course_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'course_id': course_id}
    return execute(inspect.currentframe().f_code.co_name, data)


#   Get enrollment by id
def get_enrollment_by_id(enrollment_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'enrollment_id': enrollment_id}
    return execute(inspect.currentframe().f_code.co_name, data)

#   Confirm enrollment by id
def update_enrollment_by_id(enrollment_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'enrollment_id': enrollment_id}
    return execute(inspect.currentframe().f_code.co_name, data)

#   Delete enrollment by id
def delete_enrollment_by_id(enrollment_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'enrollment_id': enrollment_id}
    return execute(inspect.currentframe().f_code.co_name, data)

#   Get enrollment by using authenticated student
def get_my_enrollment(course_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'course_id': course_id}
    return execute(inspect.currentframe().f_code.co_name, data)


#   Delete enrollment by using authenticated student
def delete_my_enrollment(course_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'course_id': course_id}
    return execute(inspect.currentframe().f_code.co_name, data)

