from flask import  request
from app.Repository.Repository import  execute
import inspect


#   Get assignment submission by id
def get_submission_by_id(submission_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'submission_id': submission_id}
    return execute(inspect.currentframe().f_code.co_name, data)
#   Get all assignment submissions
def get_all_submissions(course_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'course_id': course_id}
    return execute(inspect.currentframe().f_code.co_name, data)

#   Add assignment submission
def add_submission(assignment_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'assignment_id': assignment_id}
    return execute(inspect.currentframe().f_code.co_name, data)

#   Get assignment submission by using authenticated user
def get_my_submission(assignment_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'assignment_id': assignment_id}
    return execute(inspect.currentframe().f_code.co_name, data)

#   Delete assignment submission by using authenticated user
def delete_my_submission(assignment_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'assignment_id': assignment_id}
    return execute(inspect.currentframe().f_code.co_name, data)
