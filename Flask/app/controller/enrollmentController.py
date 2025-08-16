from flask import Blueprint
from app.service.enrollmentService import *
enrollment_blueprint = Blueprint('enrollment', __name__)




# Instructor role

#   Get all enrollments
enrollment_blueprint.route('/all',methods=['GET'])(get_all_enrollments)

#   Get enrollment by id
enrollment_blueprint.route('/<int:enrollment_id>',methods=['GET'])(get_enrollment_by_id)

#   Confirm enrollment by id
enrollment_blueprint.route('/<int:enrollment_id>',methods=['PUT'])(update_enrollment_by_id)



# Student role

#   Add new enrollment
enrollment_blueprint.route('/',methods=['POST'])(add_enrollment)

#   Get enrollment by using authenticated student
enrollment_blueprint.route('/',methods=['GET'])(get_my_enrollment)

#   Delete enrollment by using authenticated student
enrollment_blueprint.route('/',methods=['DELETE'])(delete_my_enrollment)


# Admin role

#   Delete enrollment by id
enrollment_blueprint.route('/<int:enrollment_id>',methods=['DELETE'])(delete_enrollment_by_id)