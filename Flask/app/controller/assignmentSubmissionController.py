from flask import Blueprint
from app.service.assignmentSubmissionService import *

assignment_submission_blueprint = Blueprint('assignment_submission', __name__)

# Instructor role

#   Get assignment submission by id
assignment_submission_blueprint.route('/<int:submission_id>',methods=['GET'])(get_submission_by_id)

#   Get all assignment submissions
assignment_submission_blueprint.route('/all',methods=['GET'])(get_all_submissions)



# Student role

#   Add assignment submission
assignment_submission_blueprint.route('/',methods=['POST'])(add_submission)

#   Get assignment submission by using authenticated user
assignment_submission_blueprint.route('/',methods=['GET'])(get_my_submission)

#   Delete assignment submission by using authenticated user
assignment_submission_blueprint.route('/',methods=['DELETE'])(delete_my_submission)