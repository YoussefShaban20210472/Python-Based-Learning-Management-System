from flask import Blueprint
from app.service.courseSkillService import *

course_skill_blueprint = Blueprint('course_skill', __name__)


# Instructor role

#   Add new course skill
course_skill_blueprint.route('/',methods=['POST'])(add_course_skill)

#   Get course skill
course_skill_blueprint.route('/',methods=['GET'])(get_all_course_skills)

#   Update course skill
course_skill_blueprint.route('/',methods=['PUT'])(update_course_skill)

#   Delete course skill
course_skill_blueprint.route('/',methods=['DELETE'])(delete_course_skill)


# Student role

#   Get course skill
course_skill_blueprint.route('/',methods=['GET'])(get_all_course_skills)

