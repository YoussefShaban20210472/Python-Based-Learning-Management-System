from flask import Blueprint
from app.service.mediaFileService import *

media_file_blueprint = Blueprint('media_file', __name__)




# Instructor role

#   Add new media file
media_file_blueprint.route('/',methods=['POST'])(add_media_file)

#   Get media file by id
media_file_blueprint.route('/<int:id>',methods=['GET'])(get_media_file_by_id)

#   Get all media files
media_file_blueprint.route('/all',methods=['GET'])(get_all_media_files)

#   Delete media file by id
media_file_blueprint.route('/<int:id>',methods=['DELETE'])(delete_media_file_by_id)


# Student role

#   Get media_file by id
media_file_blueprint.route('/<int:id>',methods=['GET'])(get_media_file_by_id)

#   Get all media_files
media_file_blueprint.route('/all',methods=['GET'])(get_all_media_files)

