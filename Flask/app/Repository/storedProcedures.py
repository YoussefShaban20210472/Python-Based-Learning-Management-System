stored_procedures = {
    "add_user": {
        "procedure_name": "add_user",
        "params": (
            "first_name",
            "last_name",
            "address",
            "password",
            "email",
            "phone_number",
            "birth_date",
            "gender",
            "role",
        ),
    },
    "get_user_by_id": {
        "procedure_name": "get_user",
        "params": ("actor_id", "target_id"),
    },
    "delete_user_by_id": {
        "procedure_name": "delete_user",
        "params": ("actor_id", "target_id"),
    },
    "update_user_by_id": {
        "procedure_name": "update_user",
        "params": (
            "actor_id",
            "target_id",
            "first_name",
            "last_name",
            "address",
            "password",
            "email",
            "phone_number",
            "birth_date",
            "gender",
        ),
    },
    "login": {
        "procedure_name": "user_login",
        "params": ("password", "email"),
    },
    "get_all_users": {"procedure_name": "get_users", "params": ("actor_id",)},

    "add_course":
    {
        "procedure_name": "add_course",
        "params": (
            "actor_id",
            "instructor_id",
            "title",
            "description",
            "language",
            "start_date",
            "end_date",
        ),
    },
    "update_course_by_id": {
        "procedure_name": "update_course",
        "params": (
            "actor_id",
            "course_id",
            "title",
            "description",
            "language",
            "start_date",
            "end_date",
        ),
    },
    "delete_course_by_id": {
        "procedure_name": "delete_course",
        "params": ("actor_id", "course_id"),
    },
    "get_course_by_id": {
        "procedure_name": "get_course",
        "params": ("actor_id", "course_id"),
    },
    "get_courses": {
        "procedure_name": "get_courses",
        "params": ("actor_id",),
    },
    "add_enrollment": {
        "procedure_name": "add_enrollment",
        "params": ("actor_id", "course_id", "student_id"),
    },
    "delete_enrollment_by_id": {
        "procedure_name": "delete_enrollment",
        "params": ("actor_id", "enrollment_id"),
    },
    "update_enrollment_by_id": {
        "procedure_name": "update_enrollment",
        "params": ("actor_id", "enrollment_id", "status"),
    },
    "get_enrollment_by_id": {
        "procedure_name": "get_enrollment",
        "params": ("actor_id", "enrollment_id"),
    },
    "get_enrollments": {
        "procedure_name": "get_enrollments",
        "params": ("actor_id", "course_id"),
    },
    "add_lesson": {
        "procedure_name": "add_lesson",
        "params": (
            "actor_id",
            "course_id",
            "title",
            "description",
            "start_date",
            "end_date",
            "otp",
        ),
    },
    "update_lesson_by_id": {
        "procedure_name": "update_lesson",
        "params": (
            "actor_id",
            "lesson_id",
            "title",
            "description",
            "start_date",
            "end_date",
            "otp",
        ),
    },
    "delete_lesson_by_id": {
        "procedure_name": "delete_lesson",
        "params": ("actor_id", "lesson_id"),
    },
    "get_lesson_by_id": {
        "procedure_name": "get_lesson",
        "params": ("actor_id", "lesson_id"),
    },
    "get_lessons": {
        "procedure_name": "get_lessons",
        "params": ("actor_id", "course_id"),
    },
    "add_assignment": {
        "procedure_name": "add_assignment",
        "params": (
            "actor_id",
            "course_id",
            "title",
            "description",
            "start_date",
            "end_date",
            "grade",
        ),
    },
    "update_assignment_by_id": {
        "procedure_name": "update_assignment",
        "params": (
            "actor_id",
            "assignment_id",
            "title",
            "description",
            "start_date",
            "end_date",
            "grade",
        ),
    },
    "delete_assignment_by_id": {
        "procedure_name": "delete_assignment",
        "params": ("actor_id", "assignment_id"),
    },
    "get_assignment_by_id": {
        "procedure_name": "get_assignment",
        "params": ("actor_id", "assignment_id"),
    },
    "get_assignments": {
        "procedure_name": "get_assignments",
        "params": ("actor_id", "course_id"),
    },
    "add_attendance": {
        "procedure_name": "add_attendance",
        "params": ("actor_id", "student_id", "lesson_id", "otp"),
    },
    "get_attendance_by_id": {
        "procedure_name": "get_attendance",
        "params": ("actor_id", "attendance_id"),
    },
    "get_attendances": {
        "procedure_name": "get_attendances",
        "params": ("actor_id", "course_id"),
    },
    "add_course_media_file": {
        "procedure_name": "add_course_media_file",
        "params": ("actor_id", "course_id", "path", "name", "extension"),
    },
    "delete_course_media_file_by_id": {
        "procedure_name": "delete_course_media_file",
        "params": ("actor_id", "media_file_id"),
    },
    "get_course_media_file_by_id": {
        "procedure_name": "get_course_media_file",
        "params": ("actor_id", "media_file_id"),
    },
    "get_course_media_files": {
        "procedure_name": "get_course_media_files",
        "params": ("actor_id", "course_id"),
    },
    "add_submission": {
        "procedure_name": "add_submission",
        "params": (
            "actor_id",
            "student_id",
            "assignment_id",
            "path",
            "name",
            "extension",
        ),
    },
    "delete_submission_by_id": {
        "procedure_name": "delete_submission",
        "params": ("actor_id", "submission_id"),
    },
    "get_assignment_submission_by_id": {
        "procedure_name": "get_assignment_submission",
        "params": ("actor_id", "submission_id"),
    },
    "get_assignment_submissions": {
        "procedure_name": "get_assignment_submissions",
        "params": ("actor_id", "course_id"),
    },
    "add_submission_score": {
        "procedure_name": "add_submission_score",
        "params": ("actor_id", "submission_id", "score"),
    },
    "update_submission_score": {
        "procedure_name": "update_submission_score",
        "params": ("actor_id", "submission_id", "score"),
    },
    "get_assignment_submission_score": {
        "procedure_name": "get_assignment_submission_score",
        "params": ("actor_id", "submission_id"),
    },
    "get_assignment_submissions_scores": {
        "procedure_name": "get_assignment_submissions_scores",
        "params": ("actor_id", "course_id"),
    },
    "add_quiz": {
        "procedure_name": "add_quiz",
        "params": (
            "actor_id",
            "course_id",
            "title",
            "description",
            "start_date",
            "end_date",
            "grade",
        ),
    },
    "update_quiz_by_id": {
        "procedure_name": "update_quiz",
        "params": (
            "actor_id",
            "quiz_id",
            "title",
            "description",
            "start_date",
            "end_date",
            "grade",
        ),
    },
    "delete_quiz_by_id": {
        "procedure_name": "delete_quiz",
        "params": ("actor_id", "quiz_id"),
    },
    "get_quiz_by_id": {
        "procedure_name": "get_quiz",
        "params": ("actor_id", "quiz_id"),
    },
    "get_quiz_questions": {
        "procedure_name": "get_quiz_questions",
        "params": ("actor_id", "quiz_id"),
    },
    "get_quiz_questions_choices": {
        "procedure_name": "get_quiz_questions_choices",
        "params": ("actor_id", "quiz_id"),
    },
    "get_quizzes": {
        "procedure_name": "get_quizzes",
        "params": ("actor_id", "course_id"),
    },
    "add_quiz_question": {
        "procedure_name": "add_quiz_question",
        "params": ("actor_id", "quiz_id", "title", "correct_answer", "grade", "type"),
    },
    "update_quiz_question": {
        "procedure_name": "update_quiz_question",
        "params": (
            "actor_id",
            "question_id",
            "title",
            "correct_answer",
            "grade",
            "type",
        ),
    },
    "delete_quiz_question": {
        "procedure_name": "delete_quiz_question",
        "params": ("actor_id", "question_id"),
    },
    "add_question_choice": {
        "procedure_name": "add_question_choice",
        "params": ("actor_id", "question_id", "choice"),
    },
    "update_question_choice": {
        "procedure_name": "update_question_choice",
        "params": ("actor_id", "question_id", "choice", "old_choice"),
    },
    "delete_question_choice": {
        "procedure_name": "delete_question_choice",
        "params": ("actor_id", "question_id", "choice"),
    },
    "add_bank_question": {
        "procedure_name": "add_bank_question",
        "params": ("actor_id", "course_id", "title", "correct_answer", "grade", "type"),
    },
    "add_quiz_question_from_bank": {
        "procedure_name": "add_quiz_question_from_bank",
        "params": ("actor_id", "quiz_id", "question_id"),
    },
    "add_quiz_score": {
        "procedure_name": "add_quiz_score",
        "params": ("quiz_id", "student_id", "score"),
    },
    "get_quiz_score": {
        "procedure_name": "get_quiz_score",
        "params": ("actor_id", "quiz_id", "student_id"),
    },
    "get_quizzes_scores": {
        "procedure_name": "get_quizzes_scores",
        "params": ("actor_id", "course_id"),
    },
    "add_notification": {
        "procedure_name": "add_notification",
        "params": ("course_id", "user_id", "message"),
    },
    "get_notification": {
        "procedure_name": "get_notification",
        "params": ("actor_id", "user_id"),
    },
    "add_course_category": {
        "procedure_name": "add_course_category",
        "params": ("actor_id", "course_id", "category"),
    },
    "update_course_category": {
        "procedure_name": "update_course_category",
        "params": ("actor_id", "course_id", "old_category", "category"),
    },
    "delete_course_category": {
        "procedure_name": "delete_course_category",
        "params": ("actor_id", "course_id", "category"),
    },
    "add_course_skill": {
        "procedure_name": "add_course_skill",
        "params": ("actor_id", "course_id", "skill"),
    },
    "update_course_skill": {
        "procedure_name": "update_course_skill",
        "params": ("actor_id", "course_id", "old_skill", "skill"),
    },
    "delete_course_skill": {
        "procedure_name": "delete_course_skill",
        "params": ("actor_id", "course_id", "skill"),
    },
}
