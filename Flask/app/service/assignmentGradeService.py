from flask import  request
from app.Repository.Repository import  execute
import inspect


#   Add assignment grade
def add_assignment_submission_grade(submission_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'submission_id': submission_id}
    return execute(inspect.currentframe().f_code.co_name, data)

#   Get assignment grade by id
def get_assignment_submission_grade(submission_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'submission_id': submission_id}
    return execute(inspect.currentframe().f_code.co_name, data)

#   Get assignment grades
def get_assignment_submissions_grades(course_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'course_id': course_id}
    return execute(inspect.currentframe().f_code.co_name, data)

#   Update assignment grade by id
def update_assignment_submission_grade(submission_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'submission_id': submission_id}
    return execute(inspect.currentframe().f_code.co_name, data)

#   Delete assignment grade by id
def delete_assignment_submission_grade(submission_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'submission_id': submission_id}
    return execute(inspect.currentframe().f_code.co_name, data)





