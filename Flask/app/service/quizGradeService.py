from flask import  request
from app.Repository.Repository import  execute
import inspect



#   Get quiz grade by id
def get_quiz_attempt_grade(attempt_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'attempt_id': attempt_id}
    return execute(inspect.currentframe().f_code.co_name, data)
#   Get quiz grades
def get_quizzes_attempts_grades(course_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'course_id': course_id}
    return execute(inspect.currentframe().f_code.co_name, data)

#   Get quiz grade by using authenticated student
def get_my_quiz_attempt_grade(attempt_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'attempt_id': attempt_id}
    return execute(inspect.currentframe().f_code.co_name, data)

