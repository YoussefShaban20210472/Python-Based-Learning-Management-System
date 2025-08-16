from flask import Blueprint
from app.service.attendanceService import *
attendance_blueprint = Blueprint('attendance', __name__)



# Instructor role

#   Get attendance by id
attendance_blueprint.route('/<int:attendance_id>',methods=['GET'])(get_attendance_by_id)

#   Get all attendances
attendance_blueprint.route('/all',methods=['GET'])(get_all_attendances)




# Student role

#   Attend attendance
attendance_blueprint.route('/',methods=['POST'])(add_attendance)

#   Get attendance by using authenticated student
attendance_blueprint.route('/',methods=['GET'])(get_my_attendance)

