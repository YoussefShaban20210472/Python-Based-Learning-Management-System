from flask import Blueprint
from app.service.courseService import *

course_blueprint = Blueprint('course', __name__)


# Instructor role

#   Add new course
course_blueprint.route('/',methods=['POST'])(add_course)

#   Get course by id
course_blueprint.route('/<int:course_id>',methods=['GET'])(get_course_by_id)

#   Update course by id
course_blueprint.route('/<int:course_id>',methods=['PUT'])(update_course_by_id)

#   Delete course by id
course_blueprint.route('/<int:course_id>',methods=['DELETE'])(delete_course_by_id)


# Student role

#   Get all courses
course_blueprint.route('/all',methods=['GET'])(get_all_courses)

#   Get course by id
course_blueprint.route('/<int:course_id>',methods=['GET'])(get_course_by_id)

