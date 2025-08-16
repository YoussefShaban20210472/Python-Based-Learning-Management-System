from flask import Blueprint
from app.service.assignmentService import *
assignment_blueprint = Blueprint('assignment', __name__)




#   Add new assignment
assignment_blueprint.route('/',methods=['POST'])(add_assignment)

#   Get assignment by id
assignment_blueprint.route('/<int:assignment_id>',methods=['GET'])(get_assignment_by_id)

#   Get all assignments
assignment_blueprint.route('/all',methods=['GET'])(get_all_assignments)

#   Update assignment by id
assignment_blueprint.route('/<int:assignment_id>',methods=['PUT'])(update_assignment_by_id)

#   Delete assignment by id
assignment_blueprint.route('/<int:assignment_id>',methods=['DELETE'])(delete_assignment_by_id)


