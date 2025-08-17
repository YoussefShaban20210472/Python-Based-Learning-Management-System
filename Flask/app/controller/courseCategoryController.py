from flask import Blueprint
from app.service.courseCategoryService import *

course_category_blueprint = Blueprint('course_category', __name__)


# Instructor role

#   Add new course category
course_category_blueprint.route('/',methods=['POST'])(add_course_category)

#   Get course category
course_category_blueprint.route('/',methods=['GET'])(get_all_course_categories)

#   Update course category
course_category_blueprint.route('/',methods=['PUT'])(update_course_category)

#   Delete course category
course_category_blueprint.route('/',methods=['DELETE'])(delete_course_category)


# Student role

#   Get course category
course_category_blueprint.route('/',methods=['GET'])(get_all_course_categories)

