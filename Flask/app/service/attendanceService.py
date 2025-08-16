from flask import  request

from app.Repository.Repository import  execute
import inspect


#   Get attendance by id
def get_attendance_by_id(attendance_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'attendance_id': attendance_id}
    return execute(inspect.currentframe().f_code.co_name, data)


#   Get all attendances
def get_all_attendances(course_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'course_id': course_id}
    return execute(inspect.currentframe().f_code.co_name, data)




#   Attend attendance
def add_attendance(lesson_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'lesson_id': lesson_id}
    return execute(inspect.currentframe().f_code.co_name, data)

#   Get attendance by using authenticated student
def get_my_attendance(lesson_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'lesson_id': lesson_id}
    return execute(inspect.currentframe().f_code.co_name, data)


