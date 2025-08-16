from flask import Blueprint
from app.service.userService import *
user_blueprint = Blueprint('user', __name__)




# Admin role

#   Get all users
user_blueprint.route('/all',methods=['GET'])(get_all_users)

#   Get user by id
user_blueprint.route('/<int:user_id>',methods=['GET'])(get_user_by_id)

#   Update user by id
user_blueprint.route('/<int:user_id>',methods=['PUT'])(update_user_by_id)

#   Delete user by id
user_blueprint.route('/<int:user_id>',methods=['DELETE'])(delete_user_by_id)



# any User role

#   Get user by using authenticated user
user_blueprint.route('/',methods=['GET'])(get_me)

#   Update user by using authenticated user
user_blueprint.route('/',methods=['PUT'])(update_me)

#   Delete user by using authenticated user
user_blueprint.route('/',methods=['DELETE'])(delete_me)




# APIS without role

#   Login user
user_blueprint.route('/login',methods=['POST'])(login)

#   add new user
user_blueprint.route('/',methods=['POST'])(add_user)





