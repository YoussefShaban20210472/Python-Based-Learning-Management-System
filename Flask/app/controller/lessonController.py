from flask import Blueprint
from app.service.lessonService import *
lesson_blueprint = Blueprint('lesson', __name__)


#   Add new lesson
lesson_blueprint.route('/',methods=['POST'])(add_lesson)

#   Get lesson by id
lesson_blueprint.route('/<int:lesson_id>',methods=['GET'])(get_lesson_by_id)

#   Get all lessons
lesson_blueprint.route('/all',methods=['GET'])(get_all_lessons)

#   Update lesson by id
lesson_blueprint.route('/<int:lesson_id>',methods=['PUT'])(update_lesson_by_id)

#   Delete lesson by id
lesson_blueprint.route('/<int:lesson_id>',methods=['DELETE'])(delete_lesson_by_id)


