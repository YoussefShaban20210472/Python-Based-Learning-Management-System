from flask import Blueprint

progress_blueprint = Blueprint('progress', __name__)

def demo(course_id=0):
    return 'demo'



# Instructor / Student role

#  Get progress
progress_blueprint.route('',methods=['GET'])(demo)
