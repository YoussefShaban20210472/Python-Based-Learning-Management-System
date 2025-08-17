# import base64
# import random
# import string
# import unittest
# from app import create_app
#
# app = create_app()
#
# def create_random_email():
#     length =  random.randint(5, 15)
#     part_one = ''.join(random.choice(string.ascii_letters + string.digits) for _ in range(length))
#     length = random.randint(5, 15)
#     part_two = ''.join(random.choice(string.ascii_letters + string.digits) for _ in range(length))
#     length =  random.randint(3, 5)
#     part_three = ''.join(random.choice(string.ascii_letters + string.digits) for _ in range(length))
#     return part_one + '@'+ part_two + '.' + part_three
#
#
#
# def create_basic_auth_header(username, password):
#     token = base64.b64encode(f"{username}:{password}".encode()).decode("utf-8")
#     return {"Authorization": f"Basic {token}"}
#
# email = create_random_email()
# password = "secure_hashed_password"
# auth = create_basic_auth_header(email, password)
# db = {'id':18,'email':email, 'password':password,'auth':auth}
#
# class FlaskTestCase(unittest.TestCase):
#
#     def setUp(self):
#         # Creates a test client
#         self.app = app.test_client()
#         self.app.testing = True
#
#     ## Good User Tests
#     def test_0_positive_add_user(self):
#         print('test_positive_add_user')
#         user ={
#                 "first_name": "Youssef",
#                 "last_name": "Shaban",
#                 "address": "123 Nile Street, Cairo",
#                 "password": db['password'],
#                 "email": db['email'],
#                 "phone_number": "+201234567890",
#                 "birth_date": "2000-05-15",
#                 "gender": f"{['MALE','FEMALE'][random.randint(0,1)]}",
#                 "role": f"{['ADMIN','STUDENT','INSTRUCTOR'][random.randint(0,2)]}",
#                }
#
#         response = self.app.post('/user/',json=user)
#         self.assertEqual(response.status_code, 202)
#
#     def test_1_positive_user_login(self):
#         print('test_positive_user_login')
#         user ={
#             'email': db['email'],
#             'password': db['password'],
#         }
#         response = self.app.post('/user/login',json=user)
#         db['id'] = response.get_json()[0].get('id')
#         print(f"ID:{db.get('id')}")
#         self.assertEqual(response.status_code, 200)
#
#     def test_2_positive_get_user(self):
#         print('test_positive_get_user')
#         response = self.app.get('/user/',headers=db['auth'])
#         self.assertEqual(response.status_code, 200)
#
#
#     def test_3_positive_get_user_by_id(self):
#         print('test_positive_get_user_by_id id = ',db.get('id'))
#         response = self.app.get(f'/user/{db.get("id")}',headers=db['auth'])
#         self.assertEqual(response.status_code, 200)
#
#     def test_4_positive_update_user_by_id(self):
#         user = {
#                 "email": f"{create_random_email()}",
#                }
#         response = self.app.put(f'/user/{db.get("id")}',json=user,headers=db['auth'])
#         self.assertEqual(response.status_code, 200)
#         db['email'] = user['email']
#         db['auth'] = create_basic_auth_header(db['email'], db['password'])
#
#     def test_5_positive_update_user(self):
#         user = {
#                 "email": f"{create_random_email()}",
#                }
#         response = self.app.put('/user/',json=user,headers=db['auth'])
#         self.assertEqual(response.status_code, 200)
#         db['email'] = user['email']
#         db['auth'] = create_basic_auth_header(db['email'], db['password'])
#
#     # def test_6_positive_delete_user_by_id(self):
#     #     response = self.app.delete(f'/user/{db.get("id")}',headers=db['auth'])
#     #     self.assertEqual(response.status_code, 200)
#
#     def test_7_positive_delete_user(self):
#         response = self.app.delete('/user/',headers=db['auth'])
#         self.assertEqual(response.status_code, 200)
#
#
#
# if __name__ == '__main__':
#     unittest.main()
