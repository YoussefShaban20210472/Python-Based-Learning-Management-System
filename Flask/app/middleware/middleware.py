from flask import  request
from app.Repository.userRepository import login


def authenticate():
    auth = request.authorization
    if not auth or not auth.username or not auth.password:
        return
    data = {'email': auth.username, 'password': auth.password}
    result,code = login(data)
    if code == 200:
        request.actor_id = result[0]['id']