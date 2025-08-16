from flask import  request
from app.Repository.Repository import  execute
import inspect

#   Add new media file
def add_media_file(course_id):
    data = request.get_json()
    data.update({'actor_id': getattr(request, "actor_id", None), 'course_id': course_id})
    return execute(inspect.currentframe().f_code.co_name, data)

#   Get media file by id
def get_course_media_file_by_id(media_file_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'media_file_id': media_file_id}
    return execute(inspect.currentframe().f_code.co_name, data)

#   Get all media files
def get_all_course_media_files(course_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'course_id': course_id}
    return execute(inspect.currentframe().f_code.co_name, data)

#   Delete media file by id
def delete_course_media_file_by_id(media_file_id):
    data= {'actor_id': getattr(request, "actor_id", None), 'media_file_id': media_file_id}
    return execute(inspect.currentframe().f_code.co_name, data)





