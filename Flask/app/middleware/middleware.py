from flask import  request
from app.Repository.Repository import  execute

def authenticate():
    auth = request.authorization
    if not auth or not auth.username or not auth.password:
        return
    data = {'email': auth.username, 'password': auth.password}
    result,code = execute('login',data)
    if code == 200:
        request.actor_id = result[0]['id']