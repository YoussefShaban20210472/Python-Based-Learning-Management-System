--use cc;
--drop database Flask_Learning_Management_System;
if not exists(select name from sys.databases where name = 'Flask_Learning_Management_System')
begin
	create database Flask_Learning_Management_System;
	begin try
		begin transaction
			-- User Table
			create table Flask_Learning_Management_System.dbo.[user]
			(
			-- Attributes
				id int identity(1,1),
				first_name varchar(30) not null,
				last_name varchar(30) not null,
				address varchar(200) not null,
				password varchar(500) not null,
				email varchar(100) not null ,
				phone_number varchar(30) not null ,
				birth_date date not null ,
				gender varchar(10) not null ,
				role varchar(10) not null ,
			-- Constraints
				constraint user_constraint_id_primary_key primary key(id),
				constraint user_constraint_first_name_not_empty check(len(first_name) >1),
				constraint user_constraint_last_name_not_empty check(len(last_name) >1),
				constraint user_constraint_address_not_empty check(len(address) >4),
				constraint user_constraint_password_not_empty check(len(password) >8),
				constraint user_constraint_email_not_empty check(len(email) >4),
				constraint user_constraint_email_unique unique(email),
				constraint user_constraint_phone_number_not_empty check(len(phone_number) >6),
				constraint user_constraint_birth_date_valid_age check( datediff(year, birth_date, getdate()) between 18 and 80),
				constraint user_constraint_gender_valid_value check(gender in ('MALE','FEMALE')),
				constraint user_constraint_role_valid_value check(role in ('ADMIN','STUDENT','INSTRUCTOR')),
		
			);
		
			-- Course Table
			create table Flask_Learning_Management_System.dbo.[course]
			(
			-- Attributes
				id int identity(1,1),
				instructor_id int not null ,
				title varchar(100) not null ,
				description varchar(1000) not null ,
				language varchar(50) not null,
				start_date datetime not null ,
				end_date datetime not null ,

				status as (
					case 
						when getdate() < start_date then 'NOT_STARTED'
						when getdate() between start_date and end_date then 'STARTED'
						when getdate() > end_date then 'ENDED'
					end
				)
	
			-- Constraints
				constraint course_constraint_id_primary_key primary key(id),
				constraint course_constraint_instructor_id_foreign_key foreign key(instructor_id) references Flask_Learning_Management_System.dbo.[user](id),
				constraint course_constraint_title_not_empty check(len(title) >10),
				constraint course_constraint_description_not_empty check(len(description) >50),
				constraint course_constraint_language_not_empty check(len(language) >3),

				constraint course_constraint_start_date_valid_date check (
					start_date >= cast(getdate() as date) and
					start_date <= dateadd(year, 1, cast(getdate() as date))
				),

				constraint course_constraint_end_date_valid_date check(
					end_date > start_date and 
					end_date <= dateadd(year,1,start_date)
				),

				constraint course_constraint_duration_valid_value check
				( 
					datediff(day, start_date, end_date) + 1 >= 3
				),
			);
		
			-- Catery Table
			create table Flask_Learning_Management_System.dbo.[catery]
			(
			-- Attributes
				course_id int not null ,
				catery varchar(100) not null ,
			-- Constraints
				constraint catery_constraint_course_id_and_catery_primary_key primary key(course_id,catery),
			);
		
			-- Skill Table
			create table Flask_Learning_Management_System.dbo.[skill]
			(
			-- Attributes
				course_id int not null ,
				skill varchar(100) not null ,
			-- Constraints
				constraint skill_constraint_course_id_and_skill_primary_key primary key(course_id,skill),
			);
		
			-- Media File Table
			create table Flask_Learning_Management_System.dbo.[media_file]
			(
			-- Attributes
				id int identity(1,1),
				path varchar(500) not null,
				name varchar(100) not null,
				extension varchar(100) not null,
				create_at datetime not null constraint media_file_constraint_create_at_default_value default getdate(),
			-- Constraints
				constraint media_file_constraint_id_primary_key primary key(id),
				constraint media_file_constraint_path_not_empty check(len(path) >5),
				constraint media_file_constraint_name_not_empty check(len(name) >1),
				constraint media_file_constraint_extension_not_empty check(len(extension) >1),
				constraint media_file_constraint_create_at_valid_date check(create_at >= cast(getdate() as date)),
			);
		
			-- Course Media File Table
			create table Flask_Learning_Management_System.dbo.[course_media_file]
			(
			-- Attributes
				course_id int not null ,
				media_file_id int not null ,
			-- Constraints
				constraint course_media_file_constraint_course_id_and_media_file_id_primary_key primary key(course_id,media_file_id),
				constraint course_media_file_constraint_course_id_foreign_key foreign key(course_id) references Flask_Learning_Management_System.dbo.[course](id),
				constraint course_media_file_constraint_media_file_id_foreign_key foreign key(media_file_id) references Flask_Learning_Management_System.dbo.[media_file](id),
			);
		
			-- Enrollment Table
			create table Flask_Learning_Management_System.dbo.[enrollment]
			(
			-- Attributes
				id int identity(1,1),
				course_id int not null ,
				student_id int not null ,
				status varchar(20) not null constraint enrollment_constraint_status_default_value default 'PENDING',
			-- Constraints
				constraint enrollment_constraint_id_primary_key primary key(id),
				constraint enrollment_constraint_course_id_foreign_key foreign key(course_id) references Flask_Learning_Management_System.dbo.[course](id),
				constraint enrollment_constraint_student_id_foreign_key foreign key(student_id) references Flask_Learning_Management_System.dbo.[user](id),
				constraint enrollment_constraint_course_id_and_student_id_unique unique(course_id,student_id),
				constraint enrollment_constraint_status_valid_value check(status in ('ACCEPTED','REJECTED','PENDING')),
			);
		
			-- Notification Table
			create table Flask_Learning_Management_System.dbo.[notification]
			(
			-- Attributes
				id int identity(1,1),
				course_id int not null ,
				user_id int not null ,
				message varchar(500) not null ,
				status varchar(10) not null constraint notification_constraint_status_default_value default 'unread',

			-- Constraints
				constraint notification_constraint_id_primary_key primary key(id),
				constraint notification_constraint_course_id_foreign_key foreign key(course_id) references Flask_Learning_Management_System.dbo.[course](id),
				constraint notification_constraint_user_id_foreign_key foreign key(user_id) references Flask_Learning_Management_System.dbo.[user](id),
				constraint notification_constraint_course_id_and_user_id_unique unique(course_id,user_id),
				constraint notification_constraint_message_not_empty check(len(message) >10),
				constraint notification_constraint_status_valid_value check(status in ('read', 'unread'))
			);
		
			-- Lesson Table
			create table Flask_Learning_Management_System.dbo.[lesson]
			(
			-- Attributes
				id int identity(1,1),
				course_id int not null ,
				title varchar(100) not null ,
				description varchar(1000) not null ,
				start_date datetime not null ,
				end_date datetime not null ,
				otp varchar(500) not null ,

				status as (
					case 
						when getdate() < start_date then 'NOT_STARTED'
						when getdate() between start_date and end_date then 'STARTED'
						when getdate() > end_date then 'ENDED'
					end
				)
	
			-- Constraints
				constraint lesson_constraint_id_primary_key primary key(id),
				constraint lesson_constraint_course_id_foreign_key foreign key(course_id) references Flask_Learning_Management_System.dbo.[course](id),
				constraint lesson_constraint_title_not_empty check(len(title) >10),
				constraint lesson_constraint_description_not_empty check(len(description) >50),
				constraint lesson_constraint_otp_not_empty check(len(otp) >10),

				constraint lesson_constraint_start_date_valid_date check (
					start_date >= cast(getdate() as date) and
					start_date <= dateadd(year, 1, getdate())
				),
				constraint lesson_constraint_end_date_valid_date check (
					end_date >= start_date and
					end_date <= dateadd(year, 1, start_date)
				),
				constraint lesson_constraint_duration_valid_value check
				( 
					datediff(minute, start_date, end_date) + 1 >= 15
				),
			);
		
			-- Attendance Table
			create table Flask_Learning_Management_System.dbo.[attendance]
			(
			-- Attributes
				id int identity(1,1),
				lesson_id int not null ,
				student_id int not null ,
				attendance_date date not null ,
			-- Constraints
				constraint attendance_constraint_id_primary_key primary key(id),
				constraint attendance_constraint_lesson_id_foreign_key foreign key(lesson_id) references Flask_Learning_Management_System.dbo.[lesson](id),
				constraint attendance_constraint_student_id_foreign_key foreign key(student_id) references Flask_Learning_Management_System.dbo.[user](id),
				constraint attendance_constraint_course_id_and_student_id_unique unique(lesson_id,student_id),
				constraint attendance_constraint_attendance_date_valid_date check(attendance_date >= cast(getdate() as date)),
			);
		
			-- Quiz Table
			create table Flask_Learning_Management_System.dbo.[quiz]
			(
			-- Attributes
				id int identity(1,1),
				course_id int not null ,
				title varchar(100) not null ,
				description varchar(1000) not null ,
				start_date DATETIME not null ,
				end_date DATETIME not null ,
				grade float not null ,
	
				status as (
					case 
						when getdate() < start_date then 'NOT_STARTED'
						when getdate() between start_date and end_date then 'STARTED'
						when getdate() > end_date then 'ENDED'
					end
				)

			-- Constraints
				constraint quiz_constraint_id_primary_key primary key(id),
				constraint quiz_constraint_course_id_foreign_key foreign key(course_id) references Flask_Learning_Management_System.dbo.[course](id),
				constraint quiz_constraint_title_not_empty check(len(title) >10),
				constraint quiz_constraint_description_not_empty check(len(description) >50),
				constraint quiz_constraint_grade_not_empty check(grade > 0.0 and grade <= 1000),

				constraint quiz_constraint_start_date_valid_date check (
					start_date >= cast(getdate() as date) and
					start_date <= dateadd(year, 1, getdate())
				),
				constraint quiz_constraint_end_date_valid_date check (
					end_date >= start_date and
					end_date <= dateadd(year, 1, start_date)
				), 
			);
		
			-- Question Table
			create table Flask_Learning_Management_System.dbo.[question]
			(
			-- Attributes
				id int not null,
				title varchar(100) not null ,
				correct_answer varchar(100) not null ,
				grade float not null, 
				type varchar(20) not null,
			-- Constraints
				constraint question_constraint_id_primary_key primary key(id),
				constraint question_constraint_title_not_empty check(len(title) > 5) ,
				constraint question_constraint_correct_answer_not_empty check(len(correct_answer) > 0) ,
				constraint question_constraint_grade_valid_value check(grade > 0.0 and grade < 100) ,
				constraint question_constraint_type_valid_value check(type in ('MCQ','TRUE_FALSE','SHORT_ANSWER')),
			);
		
			-- Question Choice Table
			create table Flask_Learning_Management_System.dbo.[question_choice]
			(
			-- Attributes
				question_id int not null,
				choice varchar(100) not null ,
			-- Constraints
				constraint question_choice_constraint_question_id_foreign_key foreign key(question_id) references Flask_Learning_Management_System.dbo.[question](id),
				constraint question_choice_constraint_choice_not_empty check(len(choice) > 0) ,
				constraint question_choice_constraint_question_id_and_choice_unique unique(question_id,choice) ,
			);
		
			-- Quiz Question Table
			create table Flask_Learning_Management_System.dbo.[quiz_question]
			(
			-- Attributes
				quiz_id int not null ,
				question_id int not null,
			-- Constraints
				constraint quiz_question_constraint_quiz_id_foreign_key foreign key(quiz_id) references Flask_Learning_Management_System.dbo.[quiz](id),
				constraint quiz_question_constraint_question_id_foreign_key foreign key(question_id) references Flask_Learning_Management_System.dbo.[question](id),
				constraint quiz_question_constraint_quiz_id_and_question_id_unique unique(quiz_id,question_id) ,
			);
		
			-- Bank Question Table
			create table Flask_Learning_Management_System.dbo.[bank_question]
			(
			-- Attributes
				course_id int not null ,
				question_id int not null,
			-- Constraints
				constraint bank_question_constraint_course_id_foreign_key foreign key(course_id) references Flask_Learning_Management_System.dbo.[course](id),
				constraint bank_question_constraint_question_id_foreign_key foreign key(question_id) references Flask_Learning_Management_System.dbo.[question](id),
				constraint bank_question_constraint_course_id_and_question_id_unique unique(course_id,question_id) ,
			);
		
			-- Quiz Score Table
			create table Flask_Learning_Management_System.dbo.[quiz_score]
			(
			-- Attributes
				id int identity(1,1),
				quiz_id int not null ,
				student_id int not null ,
				submission_date datetime not null ,
				score float not null,
			-- Constraints
				constraint quiz_score_constraint_id_primary_key primary key(id),
				constraint quiz_score_constraint_quiz_id_foreign_key foreign key(quiz_id) references Flask_Learning_Management_System.dbo.[quiz](id),
				constraint quiz_score_constraint_student_id_foreign_key foreign key(student_id) references Flask_Learning_Management_System.dbo.[user](id),
				constraint quiz_score_constraint_quiz_id_and_student_id_unique unique(quiz_id,student_id),
				constraint quiz_score_constraint_submission_date_valid_date check(submission_date >= cast(getdate() as date)),
				constraint quiz_score_constraint_score_valid_score check(score >= 0.0 and score < 1000),
			);
		
			-- Assignment Table
			create table Flask_Learning_Management_System.dbo.[assignment]
			(
			-- Attributes
				id int identity(1,1),
				course_id int not null ,
				title varchar(100) not null ,
				description varchar(1000) not null ,
				start_date datetime not null ,
				end_date datetime not null ,
				grade float not null ,
	
				status as (
					case 
						when getdate() < start_date then 'NOT_STARTED'
						when getdate() between start_date and end_date then 'STARTED'
						when getdate() > end_date then 'ENDED'
					end
				) 

			-- Constraints
				constraint assignment_constraint_id_primary_key primary key(id),
				constraint assignment_constraint_course_id_foreign_key foreign key(course_id) references Flask_Learning_Management_System.dbo.[course](id),
				constraint assignment_constraint_title_not_empty check(len(title) >10),
				constraint assignment_constraint_description_not_empty check(len(description) >50),
				constraint assignment_constraint_grade_valid_value check(grade > 0.0 and grade < 1000),

				constraint assignment_constraint_start_date_valid_date check (
					start_date >= cast(getdate() as date) and
					start_date <= dateadd(year, 1, getdate())
				),
				constraint assignment_constraint_end_date_valid_date check (
					end_date >= start_date and
					end_date <= dateadd(year, 1, start_date)
				),
			);
		
			-- Submission Table
			create table Flask_Learning_Management_System.dbo.[submission]
			(
			-- Attributes
				id int identity(1,1),
				submission_date datetime not null constraint submission_constraint_submission_date_default_value default getdate(),
			-- Constraints
				constraint submission_constraint_id_primary_key primary key(id),
				constraint submission_constraint_submission_date_valid_date check(submission_date >= cast(getdate() as date) ),
			);
		
			-- Submission Media File Table
			create table Flask_Learning_Management_System.dbo.[submission_media_file]
			(
			-- Attributes
				media_file_id int not null,
				submission_id int not null,
			-- Constraints
				constraint submission_media_file_constraint_media_file_id_foreign_key foreign key(media_file_id) references Flask_Learning_Management_System.dbo.[media_file](id),
				constraint submission_media_file_constraint_submission_id_foreign_key foreign key(submission_id) references Flask_Learning_Management_System.dbo.[submission](id),
				constraint submission_media_file_constraint_media_file_id_and_submission_id_unique unique(media_file_id,submission_id),
			);
		
			-- Submission Assignment Table
			create table Flask_Learning_Management_System.dbo.[submission_assignment]
			(
			-- Attributes
				student_id int not null ,
				assignment_id int not null ,
				submission_id int not null,
				score float,
			-- Constraints
				constraint submission_assignment_constraint_student_id_and_assignment_id_primary_key primary key(student_id,assignment_id),
				constraint submission_assignment_constraint_student_id_foreign_key foreign key(student_id) references Flask_Learning_Management_System.dbo.[user](id),
				constraint submission_assignment_constraint_assignment_id_foreign_key foreign key(assignment_id) references Flask_Learning_Management_System.dbo.[assignment](id),
				constraint submission_assignment_constraint_submission_id_foreign_key foreign key(submission_id) references Flask_Learning_Management_System.dbo.[submission](id),
				constraint submission_assignment_constraint_student_id_and_assignment_id_unique unique(student_id,assignment_id),
				constraint submission_assignment_constraint_submission_id_unique unique(submission_id),
				constraint submission_assignment_constraint_score_valid_value check(score > 0.0 and score < 1000),
			);
		select 'Created Tables Successfully!';
		commit
	end try
	begin catch 
		select ERROR_MESSAGE();
		rollback
	end catch

end
else
	select 'Flask_Learning_Management_System database is already existed' as ERROR