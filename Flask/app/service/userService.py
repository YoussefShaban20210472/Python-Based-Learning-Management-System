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
    data = {'actor_id': getattr(request, "actor_id", None)}
    print(data)

    return userRepository.get_all_users(data)

def get_user_by_id(id):
    data = {'actor_id': getattr(request, "actor_id", None),'target_id': id}
    print(data)
    return userRepository.get_user_by_id(data)


def update_user_by_id(id):
    data = request.get_json()
    data.update({'actor_id': getattr(request, "actor_id", None), 'target_id': id})
    print(data)
    return userRepository.update_user_by_id(data)

def delete_user_by_id(id):
    data = {'actor_id': getattr(request, "actor_id", None),'target_id': id}
    print(data)
    return userRepository.delete_user_by_id(data)


def get_me():
    data = {'actor_id': getattr(request, "actor_id", None), 'target_id': getattr(request, "actor_id", None)}
    print(data)
    return userRepository.get_user_by_id(data)

def update_me():
    data = request.get_json()
    data.update({'actor_id': getattr(request, "actor_id", None), 'target_id': getattr(request, "actor_id", None)})
    print(data)
    return userRepository.update_user_by_id(data)

def delete_me():
    data = {'actor_id': getattr(request, "actor_id", None),'target_id': getattr(request, "actor_id", None)}
    print(data)
    return userRepository.delete_user_by_id(data)





def logout():
    return 'logout',200




