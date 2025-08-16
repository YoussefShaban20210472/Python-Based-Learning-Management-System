from flask import  request
from app.Repository.Repository import  execute
import inspect


#   Add assignment grade
def add_submission_grade(submission_id):
    data = request.get_json()
    data.update({'actor_id': getattr(request, "actor_id", None), 'submission_id': submission_id})
    return execute(inspect.currentframe().f_code.co_name, data)

#   Get assignment grade by id
def get_submission_grade_by_id(submission_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'submission_id': submission_id}
    return execute(inspect.currentframe().f_code.co_name, data)

#   Get all assignments grades
def get_all_submissions_grades(course_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'course_id': course_id}
    return execute(inspect.currentframe().f_code.co_name, data)

#   Update assignment grade by id
def update_submission_grade_by_id(submission_id):
    data = request.get_json()
    data.update({'actor_id': getattr(request, "actor_id", None), 'submission_id': submission_id})
    return execute(inspect.currentframe().f_code.co_name, data)

#   Delete assignment grade by id
def delete_submission_grade_by_id(submission_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'submission_id': submission_id}
    return execute(inspect.currentframe().f_code.co_name, data)





