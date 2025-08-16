from flask import Blueprint
from app.service.notificationService import *

notification_blueprint = Blueprint('notification', __name__)

# Instructor / Student role

#  Get notification
notification_blueprint.route('/',methods=['GET'])(get_notification)
