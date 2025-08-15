from flask import Flask
from app.controller.userController import user_blueprint
from app.controller.quizController import quiz_blueprint
from app.controller.progressController import progress_blueprint
from app.controller.assignmentController import assignment_blueprint
from app.controller.notificationController import notification_blueprint
from app.controller.assignmentGradeController import assignment_grade_blueprint
from app.controller.assignmentSubmissionController import assignment_submission_blueprint
from app.controller.attendanceController import attendance_blueprint
from app.controller.courseController import course_blueprint
from app.controller.enrollmentController import enrollment_blueprint
from app.controller.lessonController import lesson_blueprint
from app.controller.mediaFileController import media_file_blueprint
from app.controller.questionBankController import question_bank_blueprint
from app.controller.quizAttemptController import quiz_attempt_blueprint
from app.controller.quizBankController import quiz_bank_blueprint
from app.controller.quizGradeController import quiz_grade_blueprint
from app.middleware.middleware import authenticate

def create_app():
    app = Flask(__name__)

    # Middlewares
    app.before_request(authenticate)




    app.register_blueprint(user_blueprint,                  url_prefix='/user')

    app.register_blueprint(course_blueprint,                url_prefix='/course')

    app.register_blueprint(quiz_blueprint,                  url_prefix='/course/<int:course_id>/quiz')
    app.register_blueprint(quiz_attempt_blueprint,          url_prefix='/course/<int:course_id>/quiz/<int:quiz_id>/attempt')
    app.register_blueprint(quiz_grade_blueprint,          url_prefix='/course/<int:course_id>/quiz/<int:quiz_id>')

    app.register_blueprint(assignment_blueprint,            url_prefix='/course/<int:course_id>/assignment')
    app.register_blueprint(assignment_submission_blueprint, url_prefix='/course/<int:course_id>/assignment/<int:assignment_id>/submission')
    app.register_blueprint(assignment_grade_blueprint,      url_prefix='/course/<int:course_id>/assignment/<int:assignment_id>/submission/')

    app.register_blueprint(enrollment_blueprint,    url_prefix='/course/<int:course_id>/enrollment')
    app.register_blueprint(lesson_blueprint,        url_prefix='/course/<int:course_id>/lesson')
    app.register_blueprint(attendance_blueprint,    url_prefix='/course/<int:course_id>/lesson/<int:lesson_id>/attendance')
    app.register_blueprint(media_file_blueprint,    url_prefix='/course/<int:course_id>/media_file')
    app.register_blueprint(progress_blueprint,      url_prefix='/course/<int:course_id>/progress')

    app.register_blueprint(question_bank_blueprint,      url_prefix='/course/<int:course_id>/bank')
    app.register_blueprint(quiz_bank_blueprint,      url_prefix='/course/<int:course_id>/bank')

    app.register_blueprint(notification_blueprint,      url_prefix='/notification')
    return app
