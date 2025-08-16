from flask import  request
from app.Repository.Repository import  execute
import inspect

#   Add new lesson
def add_lesson(course_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'course_id': course_id}
    return execute(inspect.currentframe().f_code.co_name, data)

#   Get lesson by id
def get_lesson_by_id(lesson_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'lesson_id': lesson_id}
    return execute(inspect.currentframe().f_code.co_name, data)

#   Get all lessons
def get_all_lessons(course_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'course_id': course_id}
    return execute(inspect.currentframe().f_code.co_name, data)

#   Update lesson by id
def update_lesson_by_id(lesson_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'lesson_id': lesson_id}
    return execute(inspect.currentframe().f_code.co_name, data)

#   Delete lesson by id
def delete_lesson_by_id(lesson_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'lesson_id': lesson_id}
    return execute(inspect.currentframe().f_code.co_name, data)





