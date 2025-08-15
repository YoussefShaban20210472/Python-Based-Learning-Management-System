from flask import  request
from app.Repository import  userRepository
def add_user():
    data = request.get_json()
    print(data)
    return userRepository.add_user(data)

def login():
    data = request.get_json()
    print(data)

    return userRepository.login(data)



def get_all_users():
    return 'get_all_user',200

def get_user_by_id(id):
    return 'get_user_by_id',200


def update_user_by_id(id):
    return 'update_user_by_id',200

def delete_user_by_id(id):
    return 'delete_user_by_id',200


def get_me():
    return 'get_me',200

def update_me():
    return 'get_me',200

def delete_me():
    return 'get_me',200





def logout():
    return 'logout',200




