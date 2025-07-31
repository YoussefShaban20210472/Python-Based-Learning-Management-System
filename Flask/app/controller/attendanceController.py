from flask import Blueprint

attendance_blueprint = Blueprint('attendance', __name__)

def demo():
    return 'demo'



# Instructor role

#   Get attendance by id
attendance_blueprint.route('/<int:id>',methods=['GET'])(demo)

#   Get all attendances
attendance_blueprint.route('/all',methods=['GET'])(demo)




# Student role

#   Attend attendance
attendance_blueprint.route('/',methods=['POST'])(demo)

#   Get attendance by using authenticated student
attendance_blueprint.route('/',methods=['GET'])(demo)

