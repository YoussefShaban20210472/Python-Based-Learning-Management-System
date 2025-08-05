from flask import Blueprint

assignment_submission_blueprint = Blueprint('assignment_submission', __name__)

def demo(course_id=0,assignment_id=0,id=0):
    return 'demo'



# Instructor role

#   Get assignment submission by id
assignment_submission_blueprint.route('/<int:id>',methods=['GET'])(demo)

#   Get all assignment submissions
assignment_submission_blueprint.route('/all',methods=['GET'])(demo)



# Student role

#   Add assignment submission
assignment_submission_blueprint.route('/',methods=['POST'])(demo)

#   Get assignment submission by using authenticated user
assignment_submission_blueprint.route('/',methods=['GET'])(demo)

#   Delete assignment submission by using authenticated user
assignment_submission_blueprint.route('/',methods=['DELETE'])(demo)