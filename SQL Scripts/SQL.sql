create database Flask_Learning_Management_System;
use Flask_Learning_Management_System;

create table [user](
id int identity(1,1),
first_name varchar(30) not null ,
last_name varchar(30) not null ,
address varchar(200) not null ,
password varchar(500) not null,
email varchar(100) not null ,
phone_number varchar(30) not null ,
birth_date date not null ,
gender varchar(10) not null ,
role varchar(10) not null ,



constraint user_constraint_id_primary_key primary key(id),
constraint user_constraint_first_name_not_empty check(len(first_name) >1),
constraint user_constraint_last_name_not_empty check(len(last_name) >1),
constraint user_constraint_address_not_empty check(len(address) >4),
constraint user_constraint_password_not_empty check(len(password) >8),
constraint user_constraint_email_not_empty check(len(password) >4),
constraint user_constraint_phone_number_not_empty check(len(phone_number) >6),
constraint user_constraint_birth_date_valid_age check( datediff(year, birth_date, getdate()) between 18 and 80),
constraint user_constraint_gender_valid_value check(gender in ('MALE','FEMALE')),
constraint user_constraint_role_valid_value check(role in ('ADMIN','STUDENT','INSTRUCTOR'))
)



create table [course](
id int identity(1,1),
instructor_id int not null ,
title varchar(100) not null ,
description varchar(1000) not null ,
language varchar(50) not null,
start_date DATETIME not null ,
end_date DATETIME not null ,
duration int not null ,



constraint course_constraint_id_primary_key primary key(id),
constraint course_constraint_instructor_id_foreign_key foreign key(instructor_id) references [user](id),
constraint course_constraint_title_not_empty check(len(title) >10),
constraint course_constraint_description_not_empty check(len(description) >50),
constraint course_constraint_language_not_empty check(len(language) >3),

constraint course_constraint_start_date_valid_date check (
	start_date >= CAST(GETDATE() AS DATE) AND
    start_date <= DATEADD(YEAR, 1, CAST(GETDATE() AS DATE))
),

constraint course_constraint_end_date_valid_date check(
	end_date > start_date and 
	end_date <= dateadd(year,1,start_date)
),

constraint course_constraint_duration_valid_value check
( 
	datediff(day, start_date, end_date) + 1 = duration and 
	duration >= 3
),

status AS (
    CASE 
        WHEN GETDATE() < start_date THEN 'NOT_STARTED'
        WHEN GETDATE() BETWEEN start_date AND end_date THEN 'STARTED'
        WHEN GETDATE() > end_date THEN 'ENDED'
    END
) 
)


create table [enrollment](
id int identity(1,1),
coruse_id int not null ,
student_id int not null ,
status varchar(20) not null constraint enrollment_constraint_status_default_value default 'PENDING',
constraint enrollment_constraint_id_primary_key primary key(id),
constraint enrollment_constraint_coruse_id_foreign_key foreign key(coruse_id) references [course](id),
constraint enrollment_constraint_student_id_foreign_key foreign key(student_id) references [user](id),
constraint enrollment_constraint_coruse_id_and_student_id_unique unique(coruse_id,student_id),
constraint enrollment_constraint_status_valid_value check(status in ('ACCEPTED','REJECTED','PENDING')),
)



create table [category](
course_id int not null ,
category varchar(100) not null ,

constraint category_constraint_primary_key primary key(course_id,category),
)


create table [skill](
course_id int not null ,
skill varchar(100) not null ,

constraint skill_constraint_primary_key primary key(course_id,skill),
)

create table [notification](
id int identity(1,1),
coruse_id int not null ,
user_id int not null ,
message varchar(500) not null ,
constraint notification_constraint_id_primary_key primary key(id),
constraint notification_constraint_coruse_id_foreign_key foreign key(coruse_id) references [course](id),
constraint notification_constraint_student_id_foreign_key foreign key(user_id) references [user](id),
constraint notification_constraint_coruse_id_and_student_id_unique unique(coruse_id,user_id),
constraint notification_constraint_message_not_empty check(len(message) >10),
)





create table [lesson](
id int identity(1,1),
course_id int not null ,
title varchar(100) not null ,
description varchar(1000) not null ,
start_date DATETIME not null ,
end_date DATETIME not null ,
otp varchar(500) not null ,



constraint lesson_constraint_id_primary_key primary key(id),
constraint lesson_constraint_instructor_id_foreign_key foreign key(course_id) references [course](id),
constraint lesson_constraint_title_not_empty check(len(title) >10),
constraint lesson_constraint_description_not_empty check(len(description) >50),
constraint lesson_constraint_otp_not_empty check(len(otp) >10),

CONSTRAINT lesson_constraint_start_date_valid_date CHECK (
	start_date >= GETDATE() AND
	start_date <= DATEADD(YEAR, 1, GETDATE())
),
CONSTRAINT lesson_constraint_end_date_valid_date CHECK (
	end_date >= start_date AND
	end_date <= DATEADD(YEAR, 1, start_date)
),

status AS (
    CASE 
        WHEN GETDATE() < start_date THEN 'NOT_STARTED'
        WHEN GETDATE() BETWEEN start_date AND end_date THEN 'STARTED'
        WHEN GETDATE() > end_date THEN 'ENDED'
    END
) 
)




create table [attendance](
id int identity(1,1),
lesson_id int not null ,
user_id int not null ,
attendance_date date not null ,
constraint attendance_constraint_id_primary_key primary key(id),
constraint attendance_constraint_coruse_id_foreign_key foreign key(lesson_id) references [lesson](id),
constraint attendance_constraint_student_id_foreign_key foreign key(user_id) references [user](id),
constraint attendance_constraint_coruse_id_and_student_id_unique unique(lesson_id,user_id),
constraint attendance_constraint_attendance_date_valid_date check(attendance_date >= getdate()),
)





create table [assignment](
id int identity(1,1),
course_id int not null ,
title varchar(100) not null ,
description varchar(1000) not null ,
start_date DATETIME not null ,
end_date DATETIME not null ,
grade float not null ,



constraint assignment_constraint_id_primary_key primary key(id),
constraint assignment_constraint_instructor_id_foreign_key foreign key(course_id) references [course](id),
constraint assignment_constraint_title_not_empty check(len(title) >10),
constraint assignment_constraint_description_not_empty check(len(description) >50),
constraint assignment_constraint_grade_not_empty check(grade > 0.0 and grade <= 1000),

CONSTRAINT assignment_constraint_start_date_valid_date CHECK (
	start_date >= GETDATE() AND
	start_date <= DATEADD(YEAR, 1, GETDATE())
),
CONSTRAINT assignment_constraint_end_date_valid_date CHECK (
	end_date >= start_date AND
	end_date <= DATEADD(YEAR, 1, start_date)
),

status AS (
    CASE 
        WHEN GETDATE() < start_date THEN 'NOT_STARTED'
        WHEN GETDATE() BETWEEN start_date AND end_date THEN 'STARTED'
        WHEN GETDATE() > end_date THEN 'ENDED'
    END
) 
)



create table [quiz](
id int identity(1,1),
course_id int not null ,
title varchar(100) not null ,
description varchar(1000) not null ,
start_date DATETIME not null ,
end_date DATETIME not null ,
grade float not null ,



constraint quiz_constraint_id_primary_key primary key(id),
constraint quiz_constraint_instructor_id_foreign_key foreign key(course_id) references [course](id),
constraint quiz_constraint_title_not_empty check(len(title) >10),
constraint quiz_constraint_description_not_empty check(len(description) >50),
constraint quiz_constraint_grade_not_empty check(grade > 0.0 and grade <= 1000),

CONSTRAINT quiz_constraint_start_date_valid_date CHECK (
	start_date >= GETDATE() AND
	start_date <= DATEADD(YEAR, 1, GETDATE())
),
CONSTRAINT quiz_constraint_end_date_valid_date CHECK (
	end_date >= start_date AND
	end_date <= DATEADD(YEAR, 1, start_date)
),

status AS (
    CASE 
        WHEN GETDATE() < start_date THEN 'NOT_STARTED'
        WHEN GETDATE() BETWEEN start_date AND end_date THEN 'STARTED'
        WHEN GETDATE() > end_date THEN 'ENDED'
    END
) 
)



create table [quiz_score](
id int identity(1,1),
quiz_id int not null ,
student_id int not null ,
submission_date datetime not null ,
score float not null,
constraint quiz_score_constraint_id_primary_key primary key(id),
constraint quiz_score_constraint_quiz_id_foreign_key foreign key(quiz_id) references [quiz](id),
constraint quiz_score_constraint_student_id_foreign_key foreign key(student_id) references [user](id),
constraint quiz_scoree_constraint_quiz_id_and_student_id_unique unique(quiz_id,student_id),
constraint quiz_score_constraint_submission_date_valid_date check(submission_date >= getdate()),
constraint quiz_score_constraint_score_valid_score check(score >= 0.0 and score < 1000),
)
