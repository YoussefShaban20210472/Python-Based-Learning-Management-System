from flask import Blueprint

notification_blueprint = Blueprint('notification', __name__)

def demo():
    return 'demo'



# Instructor / Student role

#  Get notification
notification_blueprint.route('/',methods=['GET'])(demo)
