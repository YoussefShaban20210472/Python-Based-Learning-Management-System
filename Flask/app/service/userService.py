from flask import  request
from app.Repository.Repository import  execute
import inspect


def add_user():
    data = request.get_json()
    return execute(inspect.currentframe().f_code.co_name,data)

def login():
    data = request.get_json()
    return execute(inspect.currentframe().f_code.co_name, data)



def get_all_users():
    data = {'actor_id': getattr(request, "actor_id", None)}
    return execute(inspect.currentframe().f_code.co_name, data)

def get_user_by_id(user_id):
    data = {'actor_id': getattr(request, "actor_id", None),'target_id': user_id}
    return execute(inspect.currentframe().f_code.co_name, data)


def update_user_by_id(user_id):
    data = request.get_json()
    data.update({'actor_id': getattr(request, "actor_id", None), 'target_id': user_id})
    return execute(inspect.currentframe().f_code.co_name, data)

def delete_user_by_id(user_id):
    data = {'actor_id': getattr(request, "actor_id", None),'target_id': user_id}
    return execute(inspect.currentframe().f_code.co_name, data)


def get_me():
    data = {'actor_id': getattr(request, "actor_id", None), 'target_id': getattr(request, "actor_id", None)}
    return execute('get_user_by_id', data)

def update_me():
    data = request.get_json()
    data.update({'actor_id': getattr(request, "actor_id", None), 'target_id': getattr(request, "actor_id", None)})
    return execute('update_user_by_id', data)

def delete_me():
    data = {'actor_id': getattr(request, "actor_id", None),'target_id': getattr(request, "actor_id", None)}
    return execute('delete_user_by_id', data)





def logout():
    return 'logout',200




