# import unittest
# from app import create_app
#
# app = create_app()
#
# class FlaskTestCase(unittest.TestCase):
#
#     def setUp(self):
#         # Creates a test client
#         self.app = app.test_client()
#         self.app.testing = True
#     ## User Tests
#     def test_post_user(self):
#         response = self.app.post('/user/')
#         self.assertEqual(response.status_code, 200)
#     def test_post_user_login(self):
#         response = self.app.post('/user/login')
#         self.assertEqual(response.status_code, 200)
#     def test_get_user(self):
#         response = self.app.get('/user/1')
#         self.assertEqual(response.status_code, 200)
#     def test_put_user(self):
#         response = self.app.put('/user/')
#         self.assertEqual(response.status_code, 200)
#     def test_delete_user(self):
#         response = self.app.delete('/user/')
#         self.assertEqual(response.status_code, 200)
#     def test_get_user_id(self):
#         response = self.app.get('/user/')
#         self.assertEqual(response.status_code, 200)
#     def test_put_user_id(self):
#         response = self.app.put('/user/1')
#         self.assertEqual(response.status_code, 200)
#     def test_delete_user_id(self):
#         response = self.app.delete('/user/1')
#         self.assertEqual(response.status_code, 200)
#
#     ## Course Tests
#     def test_post_course(self):
#         response = self.app.post('/course/')
#         self.assertEqual(response.status_code, 200)
#     def test_get_course(self):
#         response = self.app.get('/course/1')
#         self.assertEqual(response.status_code, 200)
#     def test_get_all_courses(self):
#         response = self.app.get('/course/all')
#         self.assertEqual(response.status_code, 200)
#     def test_put_course(self):
#         response = self.app.put('/course/1')
#         self.assertEqual(response.status_code, 200)
#     def test_delete_course(self):
#         response = self.app.delete('/course/1')
#         self.assertEqual(response.status_code, 200)
#
#
#     ## Enrollment Tests
#     def test_post_enrollment(self):
#         response = self.app.post('/course/1/enrollment/')
#         self.assertEqual(response.status_code, 200)
#     def test_get_enrollment(self):
#         response = self.app.get('/course/1/enrollment/')
#         self.assertEqual(response.status_code, 200)
#     def test_delete_enrollment(self):
#         response = self.app.delete('/course/1/enrollment/')
#         self.assertEqual(response.status_code, 200)
#     def test_get_enrollment_id(self):
#         response = self.app.get('/course/1/enrollment/1')
#         self.assertEqual(response.status_code, 200)
#     def test_get_all_enrollment_id(self):
#         response = self.app.get('/course/1/enrollment/all')
#         self.assertEqual(response.status_code, 200)
#     def test_put_enrollment_id(self):
#         response = self.app.put('/course/1/enrollment/1')
#         self.assertEqual(response.status_code, 200)
#
#     ## Lesson Tests
#     def test_post_lesson(self):
#         response = self.app.post('/course/1/lesson/')
#         self.assertEqual(response.status_code, 200)
#     def test_get_lesson(self):
#         response = self.app.get('/course/1/lesson/1')
#         self.assertEqual(response.status_code, 200)
#     def test_get_all_lesson(self):
#         response = self.app.get('/course/1/lesson/all')
#         self.assertEqual(response.status_code, 200)
#     def test_put_lesson(self):
#         response = self.app.put('/course/1/lesson/1')
#         self.assertEqual(response.status_code, 200)
#     def test_delete_lesson(self):
#         response = self.app.delete('/course/1/lesson/1')
#         self.assertEqual(response.status_code, 200)
#
#     ## Attendance Tests
#     def test_post_attendance(self):
#         response = self.app.post('/course/1/lesson/1/attendance/')
#         self.assertEqual(response.status_code, 200)
#     def test_get_attendance(self):
#         response = self.app.get('/course/1/lesson/1/attendance/')
#         self.assertEqual(response.status_code, 200)
#     def test_get_all_attendance(self):
#         response = self.app.get('/course/1/lesson/1/attendance/all')
#         self.assertEqual(response.status_code, 200)
#     def test_get_attendance_id(self):
#         response = self.app.get('/course/1/lesson/1/attendance/1')
#         self.assertEqual(response.status_code, 200)
#
#
#     ## Assignment  Tests
#     def test_post_assignment(self):
#         response = self.app.post('/course/1/assignment/')
#         self.assertEqual(response.status_code, 200)
#     def test_get_assignment(self):
#         response = self.app.get('/course/1/assignment/1')
#         self.assertEqual(response.status_code, 200)
#     def test_get_all_assignment(self):
#         response = self.app.get('/course/1/assignment/all')
#         self.assertEqual(response.status_code, 200)
#     def test_put_assignment(self):
#         response = self.app.put('/course/1/assignment/1')
#         self.assertEqual(response.status_code, 200)
#     def test_delete_assignment(self):
#         response = self.app.delete('/course/1/assignment/1')
#         self.assertEqual(response.status_code, 200)
#
#     ## Submission  Tests
#     def test_post_submission(self):
#         response = self.app.post('/course/1/assignment/1/submission/')
#         self.assertEqual(response.status_code, 200)
#     def test_get_submission(self):
#         response = self.app.get('/course/1/assignment/1/submission/')
#         self.assertEqual(response.status_code, 200)
#     def test_delete_submission(self):
#         response = self.app.delete('/course/1/assignment/1/submission/')
#         self.assertEqual(response.status_code, 200)
#     def test_get_all_submission(self):
#         response = self.app.get('/course/1/assignment/1/submission/all')
#         self.assertEqual(response.status_code, 200)
#     def test_get_submission_id(self):
#         response = self.app.get('/course/1/assignment/1/submission/1')
#         self.assertEqual(response.status_code, 200)
#
#     ## Submission Grade Tests
#     def test_post_assignment_grade(self):
#         response = self.app.post('/course/1/assignment/1/submission/1/grade')
#         self.assertEqual(response.status_code, 200)
#     def test_get_assignment_grade(self):
#         response = self.app.get('/course/1/assignment/1/submission/grade')
#         self.assertEqual(response.status_code, 200)
#     def test_get_all_assignment_grade(self):
#         response = self.app.get('/course/1/assignment/1/submission/all/grade')
#         self.assertEqual(response.status_code, 200)
#     def test_get_assignment_grade_id(self):
#         response = self.app.get('/course/1/assignment/1/submission/1/grade')
#         self.assertEqual(response.status_code, 200)
#     def test_put_assignment_grade_id(self):
#         response = self.app.put('/course/1/assignment/1/submission/1/grade')
#         self.assertEqual(response.status_code, 200)
#     def test_delete_assignment_grade_id(self):
#         response = self.app.delete('/course/1/assignment/1/submission/1/grade')
#         self.assertEqual(response.status_code, 200)
#
#
#     ## Media File  Tests
#     def test_post_media_file(self):
#         response = self.app.post('/course/1/media_file/')
#         self.assertEqual(response.status_code, 200)
#     def test_get_media_file(self):
#         response = self.app.get('/course/1/media_file/1')
#         self.assertEqual(response.status_code, 200)
#     def test_get_all_media_file(self):
#         response = self.app.get('/course/1/media_file/all')
#         self.assertEqual(response.status_code, 200)
#     def test_delete_media_file(self):
#         response = self.app.delete('/course/1/media_file/1')
#         self.assertEqual(response.status_code, 200)
#
#     ## Progress  Tests
#     def test_get_progress(self):
#         response = self.app.get('/course/1/progress')
#         self.assertEqual(response.status_code, 200)
#
#
#     ## Quiz  Tests
#     def test_post_quiz(self):
#         response = self.app.post('/course/1/quiz/')
#         self.assertEqual(response.status_code, 200)
#     def test_get_quiz(self):
#         response = self.app.get('/course/1/quiz/1')
#         self.assertEqual(response.status_code, 200)
#     def test_get_all_quiz(self):
#         response = self.app.get('/course/1/quiz/all')
#         self.assertEqual(response.status_code, 200)
#     def test_put_quiz(self):
#         response = self.app.put('/course/1/quiz/1')
#         self.assertEqual(response.status_code, 200)
#     def test_delete_quiz(self):
#         response = self.app.delete('/course/1/quiz/1')
#         self.assertEqual(response.status_code, 200)
#
#
#     ## Quiz Attempt  Tests
#     def test_post_attempt(self):
#         response = self.app.post('/course/1/quiz/1/attempt/')
#         self.assertEqual(response.status_code, 200)
#
#
#     ## Quiz Grade  Tests
#     def test_get_quiz_grade(self):
#         response = self.app.get('/course/1/quiz/1/attempt/1/grade')
#         self.assertEqual(response.status_code, 200)
#     def test_get_all_quiz_grade(self):
#         response = self.app.get('/course/1/quiz/1/attempt/all/grade')
#         self.assertEqual(response.status_code, 200)
#     def test_get_quiz_grade_id(self):
#         response = self.app.get('/course/1/quiz/1/attempt/grade')
#         self.assertEqual(response.status_code, 200)
#
#
#     ## Question Bank  Tests
#     def test_post_question_bank(self):
#         response = self.app.post('/course/1/bank/')
#         self.assertEqual(response.status_code, 200)
#     def test_get_question_bank(self):
#         response = self.app.get('/course/1/bank/1')
#         self.assertEqual(response.status_code, 200)
#     def test_get_all_question_bank(self):
#         response = self.app.get('/course/1/bank/all')
#         self.assertEqual(response.status_code, 200)
#     def test_put_question_bank(self):
#         response = self.app.put('/course/1/bank/1')
#         self.assertEqual(response.status_code, 200)
#     def test_delete_question_bank(self):
#         response = self.app.delete('/course/1/bank/1')
#         self.assertEqual(response.status_code, 200)
#
#     ## Quiz Bank  Tests
#     def test_post_quiz_bank(self):
#         response = self.app.post('/course/1/bank/quiz')
#         self.assertEqual(response.status_code, 200)
# if __name__ == '__main__':
#     unittest.main()
