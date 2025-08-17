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
# auth = create_basic_auth_header('youssef@aexam11pl11e.co111111s1m1', 'secure_NO_hashed_password')
# db = {'id':9,'auth':auth,'enrollment_id':17}
#
# class FlaskTestCase(unittest.TestCase):
#
#     def setUp(self):
#         # Creates a test client
#         self.app = app.test_client()
#         self.app.testing = True
#
#     ## Good Course Tests
#     def test_0_positive_add_enrollment(self):
#         enrollment ={
#                 'student_id':8
#                }
#         response = self.app.post(f'/course/{db.get("id")}/enrollment/',json=enrollment,headers=db['auth'])
#         self.assertEqual(response.status_code, 201)
#
#     def test_3_positive_get_enrollment(self):
#         response = self.app.get(f'/course/{db.get("id")}/enrollment/{db.get("enrollment_id")}',headers=db['auth'])
#         self.assertEqual(response.status_code, 200)
#
#     def test_4_positive_get_all_enrollments(self):
#         response = self.app.get(f'/course/{db.get("id")}/enrollment/all',headers=db['auth'])
#         self.assertEqual(response.status_code, 200)
#
#     def test_5_positive_update_enrollment(self):
#         enrollment = {
#                 'status': 'ACCEPTED',
#                 }
#         response = self.app.put(f'/course/{db.get("id")}/enrollment/{db.get("enrollment_id")}',json=enrollment,headers=db['auth'])
#         self.assertEqual(response.status_code, 200)
#
#     def test_6_positive_delete_enrollment(self):
#         response = self.app.delete(f'/course/{db.get("id")}/enrollment/{db.get("enrollment_id")}',headers=db['auth'])
#         self.assertEqual(response.status_code, 200)
#
# if __name__ == '__main__':
#     unittest.main()
