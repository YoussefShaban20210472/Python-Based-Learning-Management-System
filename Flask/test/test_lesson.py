# import base64
# import random
# import string
# import unittest
# from app import create_app
#
# app = create_app()
#
#
#
#
# def create_basic_auth_header(username, password):
#     token = base64.b64encode(f"{username}:{password}".encode()).decode("utf-8")
#     return {"Authorization": f"Basic {token}"}
#
#
# auth = create_basic_auth_header('gmTZ2WfaspgFRq@y0luoqKcDIQyy.60JA', 'secure_hashed_password')
# db = {'id':9,'auth':auth,'lesson_id':4}
#
# class FlaskTestCase(unittest.TestCase):
#
#     def setUp(self):
#         # Creates a test client
#         self.app = app.test_client()
#         self.app.testing = True
#
#     ## Good Course Tests
#     def test_0_positive_add_lesson(self):
#         lesson ={
#                 'title': 'd' * 20,
#                 'description': 'd' * 60,
#                 'start_date': '2025-08-17',
#                 'end_date': '2025-08-19',
#                 'otp': 'd' * 80,
#                }
#
#         response = self.app.post(f'/course/{db.get("id")}/lesson/',json=lesson,headers=db['auth'])
#         self.assertEqual(response.status_code, 202)
#
#     def test_3_positive_get_lesson(self):
#         response = self.app.get(f'/course/{db.get("id")}/lesson/{db.get("lesson_id")}',headers=db['auth'])
#         self.assertEqual(response.status_code, 200)
#
#     def test_4_positive_get_all_lesson(self):
#         response = self.app.get(f'/course/{db.get("id")}/lesson/all',headers=db['auth'])
#         self.assertEqual(response.status_code, 200)
#
#     def test_5_positive_update_lesson(self):
#         lesson = {
#                 'title': 'x' * 20,
#                 'description': 'x' * 60,
#
#                 }
#         response = self.app.put(f'/course/{db.get("id")}/lesson/{db.get("lesson_id")}',json=lesson,headers=db['auth'])
#         self.assertEqual(response.status_code, 200)
#
#     def test_6_positive_delete_lesson(self):
#         response = self.app.delete(f'/course/{db.get("id")}/lesson/{db.get("lesson_id")}',headers=db['auth'])
#         self.assertEqual(response.status_code, 200)
#
# if __name__ == '__main__':
#     unittest.main()
