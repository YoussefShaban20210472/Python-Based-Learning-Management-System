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
# db = {'id':9,'auth':auth}
#
# class FlaskTestCase(unittest.TestCase):
#
#     def setUp(self):
#         # Creates a test client
#         self.app = app.test_client()
#         self.app.testing = True
#
#     ## Good Course Tests
#     def test_0_positive_add_course_skill(self):
#         course_skill ={
#                 'skill': 'd' * 10
#                }
#
#         response = self.app.post(f'/course/{db.get("id")}/skill/',json=course_skill,headers=db['auth'])
#         self.assertEqual(response.status_code, 202)
#
#     def test_3_positive_get_course_skill(self):
#         response = self.app.get(f'/course/{db.get("id")}/skill/',headers=db['auth'])
#         self.assertEqual(response.status_code, 200)
#
#     def test_4_positive_update_course_skill(self):
#         course_skill = {
#                 'old_skill': 'd' * 10,
#                 'skill': 'd' * 10
#                 }
#         response = self.app.put(f'/course/{db.get("id")}/skill/',json=course_skill,headers=db['auth'])
#         self.assertEqual(response.status_code, 200)
#
#     def test_6_positive_delete_skill(self):
#         course_skill = {
#                     'skill': 'd' * 10
#                 }
#         response = self.app.delete(f'/course/{db.get("id")}/skill/',json=course_skill,headers=db['auth'])
#         self.assertEqual(response.status_code, 200)
#
# if __name__ == '__main__':
#     unittest.main()
