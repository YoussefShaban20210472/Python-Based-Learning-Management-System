from flask import Blueprint

user_blueprint = Blueprint('user', __name__)

def demo():
    return 'demo'


# Admin role

#   Get all users
user_blueprint.route('/all',methods=['GET'])(demo)

#   Get user by id
user_blueprint.route('/<int:id>',methods=['GET'])(demo)

#   Update user by id
user_blueprint.route('/<int:id>',methods=['PUT'])(demo)

#   Delete user by id
user_blueprint.route('/<int:id>',methods=['DELETE'])(demo)



# any User role

#   Get user using authenticated user
user_blueprint.route('/',methods=['GET'])(demo)

#   Update user using authenticated user
user_blueprint.route('/',methods=['PUT'])(demo)

#   Delete user using authenticated user
user_blueprint.route('/',methods=['DELETE'])(demo)




# APIS without role

#   Login user
user_blueprint.route('/login',methods=['POST'])(demo)

#   add new user
user_blueprint.route('/',methods=['POST'])(demo)





