from flask import Blueprint
from app.service.mediaFileService import *

media_file_blueprint = Blueprint('media_file', __name__)




# Instructor role

#   Add new media file
media_file_blueprint.route('/',methods=['POST'])(add_course_media_file)

#   Get media file by id
media_file_blueprint.route('/<int:media_file_id>',methods=['GET'])(get_course_media_file_by_id)

#   Get all media files
media_file_blueprint.route('/all',methods=['GET'])(get_all_course_media_files)

#   Delete media file by id
media_file_blueprint.route('/<int:media_file_id>',methods=['DELETE'])(delete_course_media_file_by_id)


# Student role

#   Get media_file by id
media_file_blueprint.route('/<int:media_file_id>',methods=['GET'])(get_course_media_file_by_id)

#   Get all media_files
media_file_blueprint.route('/all',methods=['GET'])(get_all_course_media_files)

