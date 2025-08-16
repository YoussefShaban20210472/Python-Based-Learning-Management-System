from flask import Blueprint
from app.service.progressService import *

progress_blueprint = Blueprint('progress', __name__)



# Instructor / Student role

#  Get progress
progress_blueprint.route('',methods=['GET'])(get_progress)
