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
# db = {'id':9,'auth':auth,'assignment_id':1}
#
# class FlaskTestCase(unittest.TestCase):
#
#     def setUp(self):
#         # Creates a test client
#         self.app = app.test_client()
#         self.app.testing = True
#
#     ## Good Course Tests
#     def test_0_positive_add_assignment(self):
#         assignment ={
#                 'title': 'd' * 20,
#                 'description': 'd' * 60,
#                 'start_date': '2025-08-17',
#                 'end_date': '2025-08-19',
#                 'grade': 50,
#                }
#
#         response = self.app.post(f'/course/{db.get("id")}/assignment/',json=assignment,headers=db['auth'])
#         self.assertEqual(response.status_code, 202)
#
#     def test_3_positive_get_assignment(self):
#         response = self.app.get(f'/course/{db.get("id")}/assignment/{db.get("assignment_id")}',headers=db['auth'])
#         self.assertEqual(response.status_code, 200)
#
#     def test_4_positive_get_all_assignment(self):
#         response = self.app.get(f'/course/{db.get("id")}/assignment/all',headers=db['auth'])
#         self.assertEqual(response.status_code, 200)
#
#     def test_5_positive_update_assignment(self):
#         assignment = {
#                 'title': 'x' * 20,
#                 'description': 'x' * 60,
#
#                 }
#         response = self.app.put(f'/course/{db.get("id")}/assignment/{db.get("assignment_id")}',json=assignment,headers=db['auth'])
#         self.assertEqual(response.status_code, 200)
#
#     def test_6_positive_delete_assignment(self):
#         response = self.app.delete(f'/course/{db.get("id")}/assignment/{db.get("assignment_id")}',headers=db['auth'])
#         self.assertEqual(response.status_code, 200)
#
# if __name__ == '__main__':
#     unittest.main()
