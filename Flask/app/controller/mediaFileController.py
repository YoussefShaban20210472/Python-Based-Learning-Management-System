from flask import Blueprint

media_file_blueprint = Blueprint('media_file', __name__)

def demo(course_id=0,id=0):
    return 'demo'



# Instructor role

#   Add new media file
media_file_blueprint.route('/',methods=['POST'])(demo)

#   Get media file by id
media_file_blueprint.route('/<int:id>',methods=['GET'])(demo)

#   Get all media files
media_file_blueprint.route('/all',methods=['GET'])(demo)

#   Delete media file by id
media_file_blueprint.route('/<int:id>',methods=['DELETE'])(demo)


# Student role

#   Get media_file by id
media_file_blueprint.route('/<int:id>',methods=['GET'])(demo)

#   Get all media_files
media_file_blueprint.route('/all',methods=['GET'])(demo)

