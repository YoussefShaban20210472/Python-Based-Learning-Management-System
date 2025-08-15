USE Flask_Learning_Management_System

GO
create schema Flask_Schema

go

create proc Flask_Schema.check_intervals
@type varchar(100),
@id int,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;

	
	if @type = 'COURSE'
		begin
			if not exists(select * from Flask_Learning_Management_System.dbo.[course] where id = @id and start_date <= getdate())
				begin	
					set @error = concat(@type,' has not started yet')
					set @code = 403
					return 
				end

			if not exists(select * from Flask_Learning_Management_System.dbo.[course] where id = @id and end_date >= getdate())
				begin	
					set @error = concat(@type,' finished')
					set @code = 403
					return 
				end
		end

	if @type = 'LESSON'
	begin
		if not exists(select * from Flask_Learning_Management_System.dbo.[lesson] where id = @id and start_date <= getdate())
			begin	
				set @error = concat(@type,' has not started yet')
				set @code = 403
				return 
			end

		if not exists(select * from Flask_Learning_Management_System.dbo.[lesson] where id = @id and end_date >= getdate())
			begin	
				set @error = concat(@type,' finished')
				set @code = 403
				return 
			end
		end
	end

	if @type = 'ASSIGNMENT'
		begin
			if not exists(select * from Flask_Learning_Management_System.dbo.[assignment] where id = @id and start_date <= getdate())
				begin	
					set @error = concat(@type,' has not started yet')
					set @code = 403
					return 
				end

			if not exists(select * from Flask_Learning_Management_System.dbo.[assignment] where id = @id and end_date >= getdate())
				begin	
					set @error = concat(@type,' finished')
					set @code = 403
					return 
				end
		end

	if @type = 'QUIZ'
		begin
			if not exists(select * from Flask_Learning_Management_System.dbo.[quiz] where id = @id and start_date <= getdate())
				begin	
					set @error = concat(@type,' has not started yet')
					set @code = 403
					return 
				end

			if not exists(select * from Flask_Learning_Management_System.dbo.[quiz] where id = @id and end_date >= getdate())
				begin	
					set @error = concat(@type,' finished')
					set @code = 403
					return 
				end
		end

	if @type = 'USER'
		return
	if @type = 'ATTENDANCE'
		return

	if @type = 'SUBMISSION'
		return
	if @type = 'MEDIA FILE'
	begin
		return
	if @type = 'QUIZ QUESTION'
		return

	if @type = 'BANK QUESTION'
		return

	if @type = 'ENROLLMENT'
		return

	if @type = 'NOTIFICATION'
		return
	if @type = 'COURSE MEDIA FILE'
		return
end

go


create proc  Flask_Schema.is_existed
@type varchar(100),
@id int,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;

	
	if @type = 'USER'
		begin
			if not exists(select * from Flask_Learning_Management_System.dbo.[user] where id = @id)
				begin	
					set @error = concat(@type,' NOT FOUND')
					set @code = 404
					return 
				end
		end

	if @type = 'COURSE'
		begin
			if not exists(select * from Flask_Learning_Management_System.dbo.[course] where id = @id)
				begin	
					set @error = concat(@type,' NOT FOUND')
					set @code = 404
					return 
				end

			if not exists(select * from Flask_Learning_Management_System.dbo.[course] where id = @id and start_date <= getdate())
				begin	
					set @error = concat(@type,' Has not started yet')
					set @code = 404
					return 
				end

			if not exists(select * from Flask_Learning_Management_System.dbo.[course] where id = @id and start_date <= getdate())
				begin	
					set @error = concat(@type,' Has not started yet')
					set @code = 404
					return 
				end
		end

	if @type = 'ENROLLMENT'
		begin
			if not exists(select * from Flask_Learning_Management_System.dbo.[enrollment] where id = @id)
				begin	
					set @error = concat(@type,' NOT FOUND')
					set @code = 404
					return 
				end
		end
	if @type = 'LESSON'
	begin
		if not exists(select * from Flask_Learning_Management_System.dbo.[lesson] where id = @id)
			begin	
				set @error = concat(@type,' NOT FOUND')
				set @code = 404
				return 
			end
	end

	if @type = 'ATTENDANCE'
		begin
			if not exists(select * from Flask_Learning_Management_System.dbo.[attendance] where id = @id)
				begin	
					set @error = concat(@type,' NOT FOUND')
					set @code = 404
					return 
				end
		end

	if @type = 'ASSIGNMENT'
		begin
			if not exists(select * from Flask_Learning_Management_System.dbo.[assignment] where id = @id)
				begin	
					set @error = concat(@type,' NOT FOUND')
					set @code = 404
					return 
				end
		end

	if @type = 'SUBMISSION'
		begin
			if not exists(select * from Flask_Learning_Management_System.dbo.[submission] where id = @id)
				begin	
					set @error = concat(@type,' NOT FOUND')
					set @code = 404
					return 
				end
		end
	if @type = 'MEDIA FILE'
	begin
		if not exists(select * from Flask_Learning_Management_System.dbo.[media_file] where id = @id)
			begin	
				set @error = concat(@type,' NOT FOUND')
				set @code = 404
				return 
			end
	end
	
	if @type = 'QUIZ'
		begin
			if not exists(select * from Flask_Learning_Management_System.dbo.[quiz] where id = @id)
				begin	
					set @error = concat(@type,' NOT FOUND')
					set @code = 404
					return 
				end
		end

	if @type = 'QUIZ QUESTION'
		begin
			if not exists(select * from Flask_Learning_Management_System.dbo.[quiz_question] where question_id = @id)
				begin	
					set @error = concat(@type,' NOT FOUND')
					set @code = 404
					return 
				end
		end

	if @type = 'BANK QUESTION'
		begin
			if not exists(select * from Flask_Learning_Management_System.dbo.bank_question where question_id = @id)
				begin	
					set @error = concat(@type,' NOT FOUND')
					set @code = 404
					return 
				end
		end

	if @type = 'NOTIFICATION'
		begin
			if not exists(select * from Flask_Learning_Management_System.dbo.[notification] where id = @id)
				begin	
					set @error = concat(@type,' NOT FOUND')
					set @code = 404
					return 
				end
		end
	if @type = 'COURSE MEDIA FILE'
		begin
			if not exists(select * from Flask_Learning_Management_System.dbo.[course_media_file] where media_file_id = @id)
				begin	
					set @error = concat(@type,' NOT FOUND')
					set @code = 404
					return 
				end
		end


	exec Flask_Schema.check_intervals
		@type=@type,
		@id=@id,
		@error = @error output,
		@code = @code output
end

go

create proc  Flask_Schema.get_course_id
@type varchar(100),
@id int,
@course_id int output
as
begin
	set nocount on;

	
	if @type = 'COURSE'
		begin
			set @course_id = @id
		end

	if @type = 'ENROLLMENT'
		begin
			select 
				@course_id = course_id 
			from Flask_Learning_Management_System.dbo.[enrollment] where id = @id
		end
	if @type = 'LESSON'
		begin	
			select 
				@course_id = course_id 
			from Flask_Learning_Management_System.dbo.[lesson] where id = @id 
		end

	if @type = 'ATTENDANCE'
		begin	
			select 
				@course_id = course_id 
			from Flask_Learning_Management_System.dbo.[attendance]  as a
			inner join
			Flask_Learning_Management_System.dbo.[lesson] as l
			on a.id = @id and a.lesson_id = l.id
		end

	if @type = 'ASSIGNMENT'
		begin	
			select 
				@course_id = course_id 
			from Flask_Learning_Management_System.dbo.[assignment] where id = @id 
		end

	if @type = 'COURSE MEDIA FILE'
		begin	
			select 
				@course_id = course_id
			from Flask_Learning_Management_System.dbo.[course_media_file] 
				where media_file_id = @id
		end
	
	if @type = 'QUIZ'
		begin	
			select 
				@course_id = course_id 
			from Flask_Learning_Management_System.dbo.[quiz] where id = @id 
		end


	if @type = 'QUIZ QUESTION'
	begin
		select 
			@course_id = course_id 
		from 
		Flask_Learning_Management_System.dbo.[quiz_question] as qq
		inner join
		Flask_Learning_Management_System.dbo.[quiz] as quiz
		on quiz.id = qq.quiz_id and qq.question_id = @id
	end

	if @type = 'BANK QUESTION'
		begin
			select 
			@course_id = course_id 
			from 
			Flask_Learning_Management_System.dbo.[bank_question]
			where question_id = @id
		end
	if @type = 'SUBMISSION'
	begin	
		select 
			@course_id= course_id
		from 
		Flask_Learning_Management_System.dbo.[submission_assignment] as sa
		inner join
		Flask_Learning_Management_System.dbo.[assignment] as assig
		on sa.submission_id = @id and assig.id = sa.assignment_id
	end

	if @type = 'NOTIFICATION'
		begin	
			select 
				@course_id = course_id 
			from Flask_Learning_Management_System.dbo.[notification] where id = @id 
		end
end

go


create proc  Flask_Schema.check_actor_belong_to
@actor_id int,
@type varchar(100),
@id int,
@error varchar(100) output,
@code int output
as 
	
begin
	-- Declare Variables
	declare 
		@user_role varchar(10),
		@instructor_id int,
		@course_id int

	-- Set User role
	select 
		@user_role = role 
		from Flask_Learning_Management_System.dbo.[user]
		where id=@actor_id


	if @type = 'USER' and @actor_id != @id and @user_role != 'ADMIN'
		begin
			set @error = 'You are not authorized to perform this action.'
			set @code = 403
			return
		end

	if @type = 'USER'
		return


	-- Set Course id
	exec Flask_Schema.get_course_id 
		@type = @type,
		@id = @id,
		@course_id = @course_id output

	-- Set Instructor id
	select 
		@instructor_id = instructor_id
		from Flask_Learning_Management_System.dbo.[course]
		where id=@course_id

	if @user_role = 'INSTRUCTOR' and @instructor_id != @actor_id
		begin
			set @error = 'You are not authorized to perform this action.'
			set @code = 403
			return
		end

	if @user_role = 'STUDENT' and not exists(select * from Flask_Learning_Management_System.dbo.[enrollment] where @actor_id = student_id and course_id = @course_id)
		begin
			set @error = 'You are not authorized to perform this action.'
			set @code = 403
			return
		end
end

go

create proc  Flask_Schema.check_security
@actor_id int,
@type varchar(100),
@id int,
@target_role varchar(20),
@error varchar(100) output,
@code int output
as
begin
	set nocount on;

	-- Check if actor is existed or no
	exec Flask_Schema.is_existed
	@type='USER',
	@id=@id,
	@error = @error output,
        @code = @code output

	if @error is not null
		begin
			set @error = 'You must be logged in to perform this action'
			set @code = 401
			return
		end 

	-- Check if object is existed or no
	exec Flask_Schema.is_existed
	@type=@type,
	@id=@id,
	@error = @error output,
        @code = @code output

	if @error is not null
		return
	
	-- Check if actor has a relation with object
	exec Flask_Schema.check_actor_belong_to
	@actor_id=@actor_id,
	@type=@type,
	@id=@id,
	@error = @error output,
        @code = @code output
	if @error is not null
		return

	-- Declare Variables
	declare 
		@user_role varchar(10)

	-- Set User role
	select 
		@user_role = role 
		from Flask_Learning_Management_System.dbo.[user]
		where id=@actor_id

	-- Check Role Authorization
	if @target_role = 'ALL' or @user_role= 'ADMIN'
		return

	if @user_role != @target_role
		begin
			set @error = 'You are not authorized to perform this action.'
			set @code = 403
			return
		end
end











































go

create proc  Flask_Schema.is_valid_string 
@attribute_name varchar(30),
@value varchar(500),
@max_length int,
@min_length int = 3,
@allowed_null int = 0,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;

	if @allowed_null = 1 and @value is null
		return
	if @value is null or len(@value) =0
	begin
		set @error= concat(@attribute_name ,' Is Required.')
		set @code = 400
		return
	end

	if len(@value) < @min_length
		begin
			set @error= concat(@attribute_name ,' Is more Than Or Equal To ',@min_length,' Characters.')
			set @code = 400
			return
		end

	if len(@value) > @max_length
	begin
		set @error= concat(@attribute_name ,' Is Less Than Or Equal To ',@max_length,' Characters.')
		set @code = 400
		return
	end
end


















go



create proc  Flask_Schema.validate_user
@first_name varchar(30) ,
@last_name varchar(30) ,
@address varchar(200) ,
@password varchar(500) ,
@email varchar(100),
@phone_number varchar(30)  ,
@birth_date date  ,
@gender varchar(10)  ,
@role varchar(10) ,
@allowed_null int = 0,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;

	-- First Name Validation
	exec Flask_Schema.is_valid_string 
		@attribute_name='First Name',
		@value = @first_name,
		@max_length= 30 ,
		@min_length=3,
		@allowed_null = @allowed_null,
		@error = @error output,
		@code = @code output
	if	@error is not null
		return

	-- Last Name Validation
	exec Flask_Schema.is_valid_string 
		@attribute_name='Last Name',
		@value = @last_name,
		@max_length= 30 ,
		@min_length=3,
		@allowed_null = @allowed_null,
		@error = @error output,
		@code = @code output
	if	@error is not null
		return

	-- Address Validation
	exec Flask_Schema.is_valid_string 
		@attribute_name='Address',
		@value = @address,
		@max_length= 200 ,
		@min_length=4,
		@allowed_null = @allowed_null,
		@error = @error output,
		@code = @code output
	if	@error is not null
		return

	-- Password Validation
	exec Flask_Schema.is_valid_string 
		@attribute_name='Password',
		@value = @password,
		@max_length= 500 ,
		@min_length=8,
		@allowed_null = @allowed_null,
		@error = @error output,
		@code = @code output
	if	@error is not null
		return

	-- Phone Number Validation
	exec Flask_Schema.is_valid_string 
		@attribute_name='Phone Number',
		@value = @phone_number,
		@max_length= 30 ,
		@min_length=6,
		@allowed_null = @allowed_null,
		@error = @error output,
		@code = @code output
	if	@error is not null
		return

	-- Gender Validation
	exec Flask_Schema.is_valid_string 
		@attribute_name='Gender',
		@value = @gender,
		@max_length= 10 ,
		@min_length=4,
		@allowed_null = @allowed_null,
		@error = @error output,
		@code = @code output
	if	@error is not null
		return
	
	if @gender is not null and @gender not in ('MALE', 'FEMALE')
		begin
			set @error = 'Gender Must Be MALE Or FEMALE'
			set @code = 400
			return
		end

	-- Role Validation
	exec Flask_Schema.is_valid_string 
		@attribute_name='Role',
		@value = @role,
		@max_length= 10 ,
		@min_length=4,
		@allowed_null = @allowed_null,
		@error = @error output,
		@code = @code output
	if	@error is not null
		return
	
	if @role is not null and @role not in ('ADMIN','STUDENT','INSTRUCTOR')
		begin
			set @error = 'Role Must Be ADMIN, STUDENT, Or INSTRUCTOR'
			set @code = 400
			return
		end
	-- Birth Date Validation
	if @birth_date is null and @allowed_null = 0
		begin
			set @error = 'Birth Date is required.'
			set @code = 400
			return
		end
	if @birth_date is not null and datediff(year, @birth_date, getdate()) not between 18 and 80
		begin
			set @error = 'Age Must Be Between 18 And 80'
			set @code = 400
			return
		end

	-- Email Validation
	exec Flask_Schema.is_valid_string 
		@attribute_name='Email',
		@value = @email,
		@max_length= 100 ,
		@min_length=6,
		@allowed_null = @allowed_null,
		@error = @error output,
		@code = @code output
	if	@error is not null
		return

end

go

create proc  Flask_Schema.validate_dates
@start_date datetime,
@end_date datetime ,
@min_duration int,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;

	-- Start Date Validation
	if @start_date is null
		begin
			set @error= 'Start Date is required'
			set @code = 400
			return
		end
	if @start_date < cast(getdate() as date)
		begin
			set @error= 'Start Date must be in future or today'
			set @code = 400
			return
		end
	if @start_date > dateadd(year, 1, cast(getdate() as date))
		begin
			set @error= 'Start Date must not exceed one year from today.'
			set @code = 400
			return
		end

	-- End Date Validation
	if @end_date is null
		begin
			set @error= 'End Date is required'
			set @code = 400
			return
		end
	if @end_date <= @start_date
		begin
			set @error= 'End Date must be after Start Date'
			set @code = 400
			return
		end
	if @end_date > dateadd(year,1,@start_date)
		begin
			set @error= 'End Date must not exceed one year from Start Date.'
			set @code = 400
			return
		end

	if datediff(minute, @start_date, @end_date)>= @min_duration
		begin
			if  @min_duration < 60
				set @error= concat('Duration must be at least ',@min_duration ,' minutes')
			else if  @min_duration >= 60
				set @error= concat('Duration must be at least ',@min_duration/60.0 ,' hours')
			else if  @min_duration >= 60 * 24
				set @error= concat('Duration must be at least ',@min_duration/(60.0*24) ,' days')
			set @code = 400
			return
		end
end

go


create proc  Flask_Schema.validate_course
@title varchar(100),
@description varchar(1000)  ,
@language varchar(50),
@start_date datetime,
@end_date datetime ,
@allowed_null int = 0,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;

	-- Title Validation
	exec Flask_Schema.is_valid_string 
		@attribute_name='Title',
		@value = @title,
		@max_length= 100 ,
		@min_length=10,
		@allowed_null = @allowed_null,
		@error = @error output,
		@code = @code output
	if	@error is not null
		return

	-- Description Validation
	exec Flask_Schema.is_valid_string 
		@attribute_name='Description',
		@value = @description,
		@max_length= 1000 ,
		@min_length=50,
		@allowed_null = @allowed_null,
		@error = @error output,
		@code = @code output
	if	@error is not null
		return

	-- Language Validation
	exec Flask_Schema.is_valid_string 
		@attribute_name='Language',
		@value = @language,
		@max_length= 50 ,
		@min_length=3,
		@allowed_null = @allowed_null,
		@error = @error output,
		@code = @code output
	if	@error is not null
		return

	-- Dates Validation
	if @allowed_null =0
		begin
			declare @min_duration int
			set @min_duration = (60 * 24 * 3)

			exec Flask_Schema.validate_dates
			@min_duration = @min_duration,
			@start_date=@start_date,
			@end_date = @end_date,
			@error = @error output,
			@code = @code output

			if	@error is not null
			return
		end
	
end

GO

create proc  Flask_Schema.validate_lesson
@title varchar(100),
@description varchar(1000),
@start_date datetime,
@end_date datetime ,
@otp varchar(500),
@allowed_null int = 0,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;

	-- Title Validation
	exec Flask_Schema.is_valid_string 
		@attribute_name='Title',
		@value = @title,
		@max_length= 100 ,
		@min_length=10,
		@allowed_null = @allowed_null,
		@error = @error output,
		@code = @code output
	if	@error is not null
		return

	-- Description Validation
	exec Flask_Schema.is_valid_string 
		@attribute_name='Description',
		@value = @description,
		@max_length= 1000 ,
		@min_length=50,
		@allowed_null = @allowed_null,
		@error = @error output,
		@code = @code output
	if	@error is not null
		return

	-- Dates Validation
	if @allowed_null =0
		begin
			declare @min_duration int
			set @min_duration = (15)

			exec Flask_Schema.validate_dates
			@min_duration = @min_duration,
			@start_date=@start_date,
			@end_date = @end_date,
			@error = @error output,
			@code = @code output

			if	@error is not null
			return
		end

	-- OTP Validation
	exec Flask_Schema.is_valid_string 
		@attribute_name='OTP',
		@value = @otp,
		@max_length= 500 ,
		@min_length=10,
		@allowed_null = @allowed_null,
		@error = @error output,
		@code = @code output
	if	@error is not null
		return
end

go

create proc  Flask_Schema.validate_assignment_quiz
@title varchar(100),
@description varchar(1000),
@start_date datetime,
@end_date datetime ,
@grade float,
@allowed_null int = 0,
@min_duration int,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;

	-- Title Validation
	exec Flask_Schema.is_valid_string 
		@attribute_name='Title',
		@value = @title,
		@max_length= 100 ,
		@min_length=10,
		@allowed_null = @allowed_null,
		@error = @error output,
		@code = @code output
	if	@error is not null
		return

	-- Description Validation
	exec Flask_Schema.is_valid_string 
		@attribute_name='Description',
		@value = @description,
		@max_length= 1000 ,
		@min_length=50,
		@allowed_null = @allowed_null,
		@error = @error output,
		@code = @code output
	if	@error is not null
		return

	-- Dates Validation
	if @allowed_null =0
		begin

			exec Flask_Schema.validate_dates
			@min_duration = @min_duration,
			@start_date=@start_date,
			@end_date = @end_date,
			@error = @error output,
			@code = @code output

			if	@error is not null
			return
		end

	-- Grade Validation
	if @grade is null
		begin
			set @error = 'Grade is required'
			set @code = 400
			return
		end
	if @grade < 0.0 or @grade > 1000
		begin
			set @error = 'Grade must be between 0 and 1000 values.'
			set @code = 400
			return
		end
end



go

create proc  Flask_Schema.validate_media_file
@path varchar(500),
@name varchar(100),
@extension varchar(100),
@allowed_null int = 0,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;

	-- Path Validation
	exec Flask_Schema.is_valid_string 
		@attribute_name='Path',
		@value = @path,
		@max_length= 500 ,
		@min_length=5,
		@allowed_null = @allowed_null,
		@error = @error output,
		@code = @code output
	if	@error is not null
		return

	-- Name Validation
	exec Flask_Schema.is_valid_string 
		@attribute_name='Name',
		@value = @name,
		@max_length= 100 ,
		@min_length=1,
		@allowed_null = @allowed_null,
		@error = @error output,
        @code = @code output
	if	@error is not null
		return

	-- Extension Validation
	exec Flask_Schema.is_valid_string 
		@attribute_name='Extension',
		@value = @extension,
		@max_length= 100,
		@min_length=1,
		@allowed_null = @allowed_null,
		@error = @error output,
        @code = @code output
	if	@error is not null
		return
end


go









create proc  Flask_Schema.validate_question
@title varchar(100) ,
@correct_answer varchar(100) ,
@grade float , 
@type varchar(20),
@allowed_null int = 0,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;

	-- Title Validation
	exec Flask_Schema.is_valid_string 
		@attribute_name='Title',
		@value = @title,
		@max_length= 100 ,
		@min_length=5,
		@allowed_null = @allowed_null,
		@error = @error output,
        @code = @code output
	if	@error is not null
		return

	-- Correct Answer Validation
	exec Flask_Schema.is_valid_string 
		@attribute_name='Correct Answer',
		@value = @correct_answer,
		@max_length= 100 ,
		@min_length=1,
		@allowed_null = @allowed_null,
		@error = @error output,
        @code = @code output
	if	@error is not null
		return

	-- Type Validation
	exec Flask_Schema.is_valid_string 
		@attribute_name='Type',
		@value = @type,
		@max_length= 20 ,
		@min_length=3,
		@allowed_null = @allowed_null,
		@error = @error output,
        @code = @code output
	if	@error is not null
		return

	if @type not in ('MCQ','TRUE_FALSE','SHORT_ANSWER')
		begin
			set @error = 'Type is not valid' 
			set @code = 400
			return 
		end 
	-- Grade Validation
	if @grade is null
		begin
			set @error = 'Grade is required'
			set @code = 400
			return
		end
	if @grade < 0.0 or @grade > 1000
		begin
			set @error = 'Grade must be between 0 and 1000 values.'
			set @code = 400
			return
		end
end











































































































go
create proc  Flask_Schema.add_user
@first_name varchar(30) ,
@last_name varchar(30) ,
@address varchar(200) ,
@password varchar(500) ,
@email varchar(100)  ,
@phone_number varchar(30)  ,
@birth_date date  ,
@gender varchar(10)  ,
@role varchar(10) ,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;

	exec Flask_Schema.validate_user
	@first_name = @first_name,
	@last_name = @last_name ,
	@address = @address ,
	@password = @password ,
	@email = @email  ,
	@phone_number= @phone_number  ,
	@birth_date = @birth_date  ,
	@gender = @gender  ,
	@role = @role ,
	@error = @error output,
    @code = @code output
	
	if @error is not null
		return 


	if exists(select * from  Flask_Learning_Management_System.dbo.[user] where email = @email)
		begin
			set @error = 'Email is already taken'
			set @code = 403
			return
		end

	-- Insert New User
	insert into Flask_Learning_Management_System.dbo.[user]
	(
			first_name ,
			last_name ,
			address,
			password,
			email,
			phone_number,
			birth_date ,
			gender ,
			role
	)
	values
	(
			@first_name ,
			@last_name ,
			@address,
			@password,
			@email,
			@phone_number,
			@birth_date ,
			@gender ,
			@role
	)

	select 'User Created Successfully' as message, 202 as code 
end

go
create proc  Flask_Schema.get_user
@actor_id int,
@target_id int,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;

	set nocount on;

	exec Flask_Schema.check_security
	@actor_id=@actor_id,
	@type='USER',
	@id=@target_id,
	@target_role = 'ALL',
	@error = @error output,
    @code = @code output
	if @error is not null
		return 
	select * from Flask_Learning_Management_System.dbo.[user] 
	where id = @target_id
end




go

create proc  Flask_Schema.delete_user
@actor_id int,
@target_id int,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;

	set nocount on;

	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='USER',
		@id=@target_id,
		@target_role = 'ALL',
		@error = @error output,
        @code = @code output
	if @error is not null
		return 

	delete from Flask_Learning_Management_System.dbo.[user]
		where id = @target_id

	select 'User Deleted Successfully' as message, 200 as code 
end


go



create proc  Flask_Schema.update_user
@actor_id int,
@target_id int,
@first_name varchar(30) ,
@last_name varchar(30) ,
@address varchar(200) ,
@password varchar(500) ,
@email varchar(100)  ,
@phone_number varchar(30)  ,
@birth_date date  ,
@gender varchar(10)  ,
@role varchar(10) ,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;

	-- Check Existing and authorizing of users
	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='USER',
		@id=@target_id,
		@target_role = 'ALL',
		@error = @error output,
        @code = @code output
	if @error is not null
		return   

	-- Declare old values attributes
	declare		
		@old_first_name varchar(30) ,
		@old_last_name varchar(30) ,
		@old_address varchar(200) ,
		@old_password varchar(500) ,
		@old_email varchar(100)  ,
		@old_phone_number varchar(30)  ,
		@old_birth_date date  ,
		@old_gender varchar(10)  ,
		@old_role varchar(10) 


	-- Assign old values attributes
	select 
		@old_first_name = first_name,
		@old_last_name = last_name ,
		@old_address = address ,
		@old_password = password ,
		@old_email = email  ,
		@old_phone_number= phone_number  ,
		@old_birth_date = birth_date  ,
		@old_gender = gender  ,
		@old_role = role 
	from Flask_Learning_Management_System.dbo.[user]
	where id = @target_id


	-- Assing the old Value if the new value is null
	if @first_name is null
		set @first_name = @old_first_name

	if @last_name is null
		set @last_name = @old_last_name

	if @address is null
		set @address = @old_address

	if @email is null
		set @email = @old_email

	if @phone_number is null
		set @phone_number = @old_phone_number

	if @birth_date is null
		set @birth_date = @old_birth_date

	if @gender is null
		set @gender = @old_gender

	if @role is null
		set @role = @old_role

	-- Validate new attributes
	exec Flask_Schema.validate_user
	@first_name = @first_name,
	@last_name = @last_name ,
	@address = @address ,
	@password = @password ,
	@email = @email  ,
	@phone_number= @phone_number  ,
	@birth_date = @birth_date  ,
	@gender = @gender  ,
	@role = @role ,
	@allowed_null = 1,
	@error = @error output,
        @code = @code output
	

	if @error is not null
		return 

	
	if @email != @old_email and exists(select * from  Flask_Learning_Management_System.dbo.[user] where email = @email)
	begin
		set @error = 'Email is already taken'
		set @code = 400
		return
	end

	-- Update User	
	update Flask_Learning_Management_System.dbo.[user]
	set first_name = @first_name,
		last_name = @last_name ,
		address = @address ,
		password = @password ,
		email = @email  ,
		phone_number= @phone_number  ,
		birth_date = @birth_date  ,
		gender = @gender  ,
		role = @role 
	where id = @target_id
	
	select 'User Updated Successfully' as message, 200 as code 
end

go



create proc  Flask_Schema.user_login
@password varchar(500) ,
@email varchar(100),
@error varchar(100) output,
@code int output
as
begin
	set nocount on;

	if not exists(select * from Flask_Learning_Management_System.dbo.[user] where email = @email and password = @password)
		begin
			set @error = 'User Not Found'
			set @code  = 404
			return
		end

	select id, email, password from Flask_Learning_Management_System.dbo.[user]
	where email = @email and password = @password

end

go

create proc  Flask_Schema.get_users
@actor_id int,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	if not exists(select * from Flask_Learning_Management_System.dbo.[user] where id = @actor_id)
	begin
		set @error = 'You must be logged in to perform this action'
		set @code = 401
		return
	end
	
	if not exists(select * from Flask_Learning_Management_System.dbo.[user] where id = @actor_id and role = 'ADMIN')
		begin
			set @error = 'You are not authorized to perform this action'
			set @code = 403
			return
		end 

	select * from Flask_Learning_Management_System.dbo.[user]
end


































go




create proc  Flask_Schema.add_course
@actor_id int,
@instructor_id int ,
@title varchar(100) ,
@description varchar(1000)  ,
@language varchar(50),
@start_date datetime ,
@end_date datetime ,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='USER',
		@id=@instructor_id,
		@target_role = 'INSTRUCTOR',
		@error = @error output,
        @code = @code output
	if @error is not null
		return   

	exec Flask_Schema.validate_course
	@title = @title,
	@description = @description ,
	@language = @language ,
	@start_date = @start_date  ,
	@end_date= @end_date  ,
	@error = @error output,
    @code = @code output	
	if @error is not null
		return 

	-- Insert New Course
	insert into Flask_Learning_Management_System.dbo.[course]
	(
			instructor_id ,
			title ,
			description,
			language,
			start_date,
			end_date
	)
	values
	(
			@instructor_id ,
			@title ,
			@description,
			@language,
			@start_date,
			@end_date
	)


	select 'Course Created Successfully' as message, 202 as code 
end

go



create proc  Flask_Schema.update_course
@actor_id int,
@course_id int ,
@title varchar(100) ,
@description varchar(1000)  ,
@language varchar(50),
@start_date datetime ,
@end_date datetime ,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;

	
	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='COURSE',
		@id=@course_id,
		@target_role = 'INSTRUCTOR',
		@error = @error output,
        @code = @code output
	if @error is not null
		return  

	-- Declare old values attributes
	declare		
		@old_title varchar(100) ,
		@old_description varchar(1000)  ,
		@old_language varchar(50),
		@old_start_date datetime ,
		@old_end_date datetime 


	-- Assign old values attributes
	select 
		@old_title = title,
		@old_description = description ,
		@old_language = language ,
		@old_start_date = start_date ,
		@old_end_date = end_date  
	from Flask_Learning_Management_System.dbo.[course]
	where id = @course_id


	-- Assing the old Value if the new value is null
	if @title is null
		set @title = @old_title

	if @description is null
		set @description = @old_description

	if @start_date is null
		set @start_date = @old_start_date

	if @end_date is null
		set @end_date = @old_end_date


	-- Validate new attributes
	exec Flask_Schema.validate_course
	@title = @title,
	@description = @description ,
	@language = @language ,
	@start_date = @start_date  ,
	@end_date= @end_date  ,
	@error = @error output,
        @code = @code output	
	if @error is not null
		return
		
	-- Update course
	update Flask_Learning_Management_System.dbo.[course]
	set 
		title = @title,
		description = @description ,
		language = @language ,
		start_date = @start_date ,
		end_date = @end_date  
	where id = @course_id

	select 'Course Updated Successfully' as message, 200 as code
end


go


create proc  Flask_Schema.delete_course
@actor_id int,
@course_id int ,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;

	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='COURSE',
		@id=@course_id,
		@target_role = 'INSTRUCTOR',
		@error = @error output,
        @code = @code output
	if @error is not null
		return 

	delete from Flask_Learning_Management_System.dbo.[course]
	where id = @course_id

	select 'Course Deleted Successfully' as message, 200 as code
end


go


create proc  Flask_Schema.get_course
@actor_id int,
@course_id int ,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='COURSE',
		@id=@course_id,
		@target_role = 'ALL',
		@error = @error output,
        @code = @code output
	if @error is not null
		return


	select 
		title,
		description,
		language,
		start_date,
		end_date  
	from Flask_Learning_Management_System.dbo.[course] where id = @course_id
end




go


create proc  Flask_Schema.get_courses
@actor_id int,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;

	if not exists(select * from Flask_Learning_Management_System.dbo.[user] where id = @actor_id)
		begin
			set @error = 'You must be logged in to perform this action'
			set @code = 401
			return
		end
	
	if not exists(select * from Flask_Learning_Management_System.dbo.[user] where id = @actor_id and role = 'ADMIN')
		begin
			set @error = 'You are not authorized to perform this action'
			set @code = 403
			return
		end 

	select 
		title,
		description,
		language,
		start_date,
		end_date  
	from Flask_Learning_Management_System.dbo.[course]
end



















go

create proc  Flask_Schema.add_enrollment
@actor_id int,
@course_id int,
@student_id int,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;

	
	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='USER',
		@id=@student_id,
		@target_role = 'STUDENT',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	exec Flask_Schema.check_security
		@actor_id=@student_id,
		@type='COURSE',
		@id=@course_id,
		@target_role = 'STUDENT',
		@error = @error output,
        @code = @code output
	if @error is not null
		return



	insert into Flask_Learning_Management_System.dbo.[enrollment]
	(
	course_id,
	student_id
	)
	values
	(
	@course_id,
	@student_id
	)

	select 'Enrollment Created Successfully' as message, 202 as code

end



go



create proc  Flask_Schema.delete_enrollment
@actor_id int,
@enrollment_id int,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;

	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='ENROLLMENT',
		@id=@enrollment_id,
		@target_role = 'STUDENT',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	declare 
		@user_role varchar(10),
		@status varchar(20)

	select 
		@user_role = role
		from Flask_Learning_Management_System.dbo.[user]
		where @actor_id = id

	select 
		@status = status
		from Flask_Learning_Management_System.dbo.[enrollment]
		where @enrollment_id = id


	if @user_role = 'STUDENT' AND @status = 'REJECTED'
		begin
			set @error = 'You are not authorized to perform this action.'
			set @code = 403
			return
		end

	delete from Flask_Learning_Management_System.dbo.[enrollment] where id = @enrollment_id

	select 'Enrollment Deleted Successfully' as message, 200 as code
end

go

create proc  Flask_Schema.update_enrollment
@actor_id int,
@enrollment_id int,
@status varchar(20),
@error varchar(100) output,
@code int output
as
begin
	set nocount on;

	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='ENROLLMENT',
		@id=@enrollment_id,
		@target_role = 'INSTRUCTOR',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	
	if @status is null or len(@status) = 0
		begin
			set @error = 'Status is required'
			set @code = 400
			return
		end

	if @status not in ('ACCEPTED','REJECTED')
	begin
		set @error = 'Status is not valid value'
		set @code = 400
		return
	end

	update Flask_Learning_Management_System.dbo.[enrollment] 
		set status = @status
	where id = @enrollment_id

	select 'Enrollment Updated Successfully' as message, 200 as code
end


go

create proc  Flask_Schema.get_enrollment
@actor_id int,
@enrollment_id int,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='ENROLLMENT',
		@id=@enrollment_id,
		@target_role = 'ALL',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	select * from Flask_Learning_Management_System.dbo.[enrollment] where id = @enrollment_id
end

go

create proc  Flask_Schema.get_enrollments
@actor_id int,
@course_id int,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;

	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='COURSE',
		@id=@course_id,
		@target_role = 'INSTRUCTOR',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	select * from Flask_Learning_Management_System.dbo.[enrollment] where course_id = @course_id
end






























GO
create proc  Flask_Schema.add_lesson
@actor_id int,
@course_id int ,
@title varchar(100) ,
@description varchar(1000),
@start_date datetime ,
@end_date datetime ,
@otp varchar(500) ,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='COURSE',
		@id=@course_id,
		@target_role = 'INSTRUCTOR',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	exec Flask_Schema.validate_lesson
	@title = @title,
	@description = @description ,
	@otp = @otp ,
	@start_date = @start_date  ,
	@end_date= @end_date  ,
	@error = @error output,
    @code = @code output	
	if @error is not null
		return 

	-- Insert New Lesson
	insert into Flask_Learning_Management_System.dbo.[lesson]
	(
			course_id ,
			title ,
			description,
			otp,
			start_date,
			end_date
	)
	values
	(
			@course_id ,
			@title ,
			@description,
			@otp,
			@start_date,
			@end_date
	)

	select 'Lesson Created Successfully' as message, 202 as code
end

go



create proc  Flask_Schema.update_lesson
@actor_id int,
@lesson_id int ,
@title varchar(100) ,
@description varchar(1000),
@start_date datetime ,
@end_date datetime ,
@otp varchar(500) ,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='LESSON',
		@id=@lesson_id,
		@target_role = 'INSTRUCTOR',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	-- Declare old values attributes
	declare		
		@old_title varchar(100) ,
		@old_description varchar(1000)  ,
		@old_language varchar(50),
		@old_start_date datetime ,
		@old_end_date datetime,
		@old_otp varchar(500)


	-- Assign old values attributes
	select 
		@old_title = title,
		@old_description = description ,
		@old_otp = otp ,
		@old_start_date = start_date ,
		@old_end_date = end_date  
	from Flask_Learning_Management_System.dbo.[lesson]
	where id = @lesson_id


	-- Assing the old Value if the new value is null
	if @title is null
		set @title = @old_title

	if @description is null
		set @description = @old_description

	if @start_date is null
		set @start_date = @old_start_date

	if @end_date is null
		set @end_date = @old_end_date

	if @otp is null
		set @otp = @old_otp

	-- Validate new attributes
	exec Flask_Schema.validate_lesson
	@title = @title,
	@description = @description ,
	@otp = @otp,
	@start_date = @start_date  ,
	@end_date= @end_date  ,
	@error = @error output,
    @code = @code output	
	if @error is not null
		return
		
	-- Update lesson
	update Flask_Learning_Management_System.dbo.[lesson]
	set 
		title = @title,
		description = @description ,
		otp =  @otp ,
		start_date = @start_date ,
		end_date = @end_date  
	where id = @lesson_id

	select 'Lesson Updated Successfully' as message, 200 as code
end




go


create proc  Flask_Schema.delete_lesson
@actor_id int,
@lesson_id int ,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='LESSON',
		@id=@lesson_id,
		@target_role = 'INSTRUCTOR',
		@error = @error output,
        @code = @code output
	if @error is not null
		return
		
	-- Delete lesson
	delete from Flask_Learning_Management_System.dbo.[lesson]
	where id = @lesson_id

	select 'Lesson Deleted Successfully' as message, 200 as code
end










go


create proc  Flask_Schema.get_lesson
@actor_id int,
@lesson_id int,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='LESSON',
		@id=@lesson_id,
		@target_role = 'ALL',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	declare 
		@user_role varchar(10)
		
	select 
		@user_role = role
		from Flask_Learning_Management_System.dbo.[user]
		where id = @actor_id
	
	if @user_role ='STUDENT'
		begin
			select less.title,less.description,iif(attend.student_id IS NOT NULL, 1, 0) as attended
			from Flask_Learning_Management_System.dbo.[lesson] as less
			left join
			Flask_Learning_Management_System.dbo.[attendance] as attend
			on @actor_id = attend.student_id and less.id = @lesson_id
			
			return
		end
	else
		begin
			select * from Flask_Learning_Management_System.dbo.[lesson] where id = @lesson_id
		end
end


go


create proc  Flask_Schema.get_lessons
@actor_id int,
@course_id int,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='COURSE',
		@id=@course_id,
		@target_role = 'ALL',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	declare 
	@user_role varchar(10)
		
	select 
		@user_role = role
		from Flask_Learning_Management_System.dbo.[user]
		where id = @actor_id


	if @user_role ='STUDENT'
		begin
			select less.title,less.description,iif(attend.student_id IS NOT NULL, 1, 0) as attended
			from Flask_Learning_Management_System.dbo.[lesson] as less
			left join
			Flask_Learning_Management_System.dbo.[attendance] as attend
			on @actor_id = attend.student_id and less.course_id = @course_id
			
			return
		end
	else
		begin
			select * from Flask_Learning_Management_System.dbo.[lesson] where course_id = @course_id
		end
end



















go


create proc  Flask_Schema.add_assignment
@actor_id int,
@course_id int ,
@title varchar(100) ,
@description varchar(1000),
@start_date datetime ,
@end_date datetime ,
@grade float ,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='COURSE',
		@id=@course_id,
		@target_role = 'INSTRUCTOR',
		@error = @error output,
        @code = @code output
	if @error is not null
		return


	-- Validatate Assignment attributes
	declare @min_duration int
	set @min_duration = (60 * 24)

	exec Flask_Schema.validate_assignment_quiz
	@title = @title,
	@description = @description ,
	@grade = @grade ,
	@start_date = @start_date  ,
	@min_duration = @min_duration,
	@end_date= @end_date  ,
	@error = @error output,
    @code = @code output	
	if @error is not null
		return 


	-- Insert New Assignmnet
	insert into Flask_Learning_Management_System.dbo.[assignment]
	(
			course_id ,
			title ,
			description,
			grade,
			start_date,
			end_date
	)
	values
	(
			@course_id ,
			@title ,
			@description,
			@grade,
			@start_date,
			@end_date
	)

	select 'Assignment Created Successfully' as message, 202 as code
end

go



create proc  Flask_Schema.update_assignment
@actor_id int,
@assignment_id int ,
@title varchar(100) ,
@description varchar(1000),
@start_date datetime ,
@end_date datetime ,
@grade float ,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='ASSIGNMENT',
		@id=@assignment_id,
		@target_role = 'INSTRUCTOR',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	-- Declare old values attributes
	declare		
		@old_title varchar(100) ,
		@old_description varchar(1000)  ,
		@old_language varchar(50),
		@old_start_date datetime ,
		@old_end_date datetime,
		@old_grade float


	-- Assign old values attributes
	select 
		@old_title = title,
		@old_description = description ,
		@old_grade = grade ,
		@old_start_date = start_date ,
		@old_end_date = end_date  
	from Flask_Learning_Management_System.dbo.[assignment]
	where id = @assignment_id


	-- Assing the old Value if the new value is null
	if @title is null
		set @title = @old_title

	if @description is null
		set @description = @old_description

	if @start_date is null
		set @start_date = @old_start_date

	if @end_date is null
		set @end_date = @old_end_date

	if @grade is null
		set @grade = @old_grade

	-- Validate new attributes
	declare @min_duration int
	set @min_duration = (60 * 24)
	exec Flask_Schema.validate_assignment_quiz
	@title = @title,
	@description = @description ,
	@grade = @grade ,
	@start_date = @start_date  ,
	@min_duration = @min_duration,
	@end_date= @end_date  ,
	@error = @error output,
    @code = @code output	
	if @error is not null
		return 
		
	-- Update assignment
	update Flask_Learning_Management_System.dbo.[assignment]
	set 
		title = @title,
		description = @description ,
		grade =  @grade ,
		start_date = @start_date ,
		end_date = @end_date  
	where id = @assignment_id

	select 'Assignment Updated Successfully' as message, 200 as code
end




go


create proc  Flask_Schema.delete_assignment
@actor_id int,
@assignment_id int ,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='ASSIGNMENT',
		@id=@assignment_id,
		@target_role = 'INSTRUCTOR',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	-- Delete lesson
	delete from Flask_Learning_Management_System.dbo.[assignment]
	where id = @assignment_id

	select 'Assignment Deleted Successfully' as message, 200 as code
end


go


create proc  Flask_Schema.get_assignment
@actor_id int,
@assignment_id int,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='ASSIGNMENT',
		@id=@assignment_id,
		@target_role = 'ALL',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	declare 
	@user_role varchar(10)
		
	select 
		@user_role = role
		from Flask_Learning_Management_System.dbo.[user]
		where id = @actor_id

	if @user_role ='STUDENT'
		begin
			select assig.title,assig.description,iif(subm.student_id IS NOT NULL, 1, 0) as submited
			from Flask_Learning_Management_System.dbo.[assignment] as assig
			left join
			Flask_Learning_Management_System.dbo.[submission_assignment] as subm
			on @actor_id = subm.student_id and assig.id = @assignment_id
			
			return
		end
	else
	begin
		select * from Flask_Learning_Management_System.dbo.[assignment] where id = @assignment_id
	end
end


go


create proc  Flask_Schema.get_assignments
@actor_id int,
@course_id int,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;

	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='COURSE',
		@id=@course_id,
		@target_role = 'ALL',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	declare 
	@user_role varchar(10)
		
	select 
		@user_role = role
		from Flask_Learning_Management_System.dbo.[user]
		where id = @actor_id


	if @user_role ='STUDENT'
		begin
			select assig.title,assig.description,iif(subm.student_id IS NOT NULL, 1, 0) as submited
			from Flask_Learning_Management_System.dbo.[assignment] as assig
			left join
			Flask_Learning_Management_System.dbo.[submission_assignment] as subm
			on @actor_id = subm.student_id and assig.course_id = @course_id
			
			return
		end
	else
	begin
		select * from Flask_Learning_Management_System.dbo.[assignment] where course_id = @course_id
	end
end




















go


create proc  Flask_Schema.add_attendance
@actor_id int,
@student_id int,
@lesson_id int,
@otp varchar(500) ,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;

	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='USER',
		@id=@student_id,
		@target_role = 'STUDENT',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	exec Flask_Schema.check_security
		@actor_id=@student_id,
		@type='LESSON',
		@id=@lesson_id,
		@target_role = 'STUDENT',
		@error = @error output,
        @code = @code output
	if @error is not null
		return


	-- add new attendance
	insert into  Flask_Learning_Management_System.dbo.[attendance]
	(
	lesson_id,
	student_id
	)
	values
	(
	@lesson_id,
	@student_id
	)

	select 'Attendance Created Successfully' as message, 202 as code

end



go



create proc  Flask_Schema.get_attendance
@actor_id int,
@attendance_id int,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	 exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='ATTENDANCE',
		@id=@attendance_id,
		@target_role = 'ALL',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	if	exists(select * from Flask_Learning_Management_System.dbo.[user] where id = @actor_id and role = 'STUDENT')
		and
		not exists(select * from Flask_Learning_Management_System.dbo.[attendance] where student_id = @actor_id and id = @attendance_id)

		begin
			set @error = 'You are not authorized to perform this action.'
			set @code = 403
			return 
		end
		
	select * from Flask_Learning_Management_System.dbo.[attendance]
	where id =@attendance_id
end



go



create proc  Flask_Schema.get_attendances
@actor_id int,
@course_id int,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='COURSE',
		@id=@course_id,
		@target_role = 'INSTRUCTOR',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	select attend.* 
	from Flask_Learning_Management_System.dbo.[course] as cour
	inner join
	Flask_Learning_Management_System.dbo.[lesson] as less
	on cour.id = @course_id and less.course_id =  @course_id
	inner join
	Flask_Learning_Management_System.dbo.[attendance] as attend
	 on less.id = attend.lesson_id
end

























go


create proc  Flask_Schema.add_course_media_file
@actor_id int,
@course_id int ,
@path varchar(500) ,
@name varchar(100) ,
@extension varchar(100) ,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='COURSE',
		@id=@course_id,
		@target_role = 'INSTRUCTOR',
		@error = @error output,
        @code = @code output
	if @error is not null
		return


	exec Flask_Schema.validate_media_file
	@path = @path,
	@name = @name ,
	@extension = @extension ,
	@error = @error output,
    @code = @code output	
	if @error is not null
		return 

	-- Insert New course media file
	insert into Flask_Learning_Management_System.dbo.[media_file]
	(
			path,
			name,
			extension
	)
	values
	(
			@path,
			@name,
			@extension
	)

	insert into Flask_Learning_Management_System.dbo.[course_media_file]
	(
			course_id,
			media_file_id
	)
	values
	(
			@course_id,
			cast(SCOPE_IDENTITY() as int)
	)

	select 'File Uploaded Successfully' as message, 200 as code
end


go

create proc  Flask_Schema.delete_course_media_file
@actor_id int,
@media_file_id int ,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='COURSE MEDIA FILE',
		@id=@media_file_id,
		@target_role = 'INSTRUCTOR',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	-- Delete course media file
	delete from Flask_Learning_Management_System.dbo.[course_media_file]
	where media_file_id = @media_file_id

	delete from Flask_Learning_Management_System.dbo.[media_file]
	where id = @media_file_id

	select 'File Deleted Successfully' as message, 200 as code
end










go


create proc  Flask_Schema.get_course_media_file
@actor_id int,
@media_file_id int ,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='COURSE MEDIA FILE',
		@id=@media_file_id,
		@target_role = 'ALL',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	-- get course media file

	select * from Flask_Learning_Management_System.dbo.[media_file]
	where id = @media_file_id
end

go


create proc  Flask_Schema.get_course_media_files
@actor_id int,
@course_id int ,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='COURSE',
		@id=@course_id,
		@target_role = 'ALL',
		@error = @error output,
        @code = @code output
	if @error is not null
		return


	-- get course media files
	select cmf.* 
	from Flask_Learning_Management_System.dbo.[course_media_file] as cmf
	inner join
	Flask_Learning_Management_System.dbo.[media_file] as mf
	on cmf.course_id = @course_id and mf.id = cmf.media_file_id
end


















































go

create proc  Flask_Schema.add_submission
@actor_id int,
@student_id int,
@assignment_id int,
@path varchar(500) ,
@name varchar(100) ,
@extension varchar(100),
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	 exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='USER',
		@id=@student_id,
		@target_role = 'STUDENT',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	 exec Flask_Schema.check_security
		@actor_id=@student_id,
		@type='ASSIGNMENT',
		@id=@assignment_id,
		@target_role = 'ALL',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	exec Flask_Schema.validate_media_file
	@path = @path,
	@name = @name ,
	@extension = @extension ,
	@error = @error output,
        @code = @code output	
	if @error is not null
		return 

	-- Insert New course media file
	insert into Flask_Learning_Management_System.dbo.[media_file]
	(
			path,
			name,
			extension
	)
	values
	(
			@path,
			@name,
			@extension
	)

	declare @media_file_id int,
			@submission_id int

	set @media_file_id= cast(SCOPE_IDENTITY() as int)



	 select @submission_id = submission_id 
	 from Flask_Learning_Management_System.dbo.[submission_assignment] 
	 where student_id = @student_id and @assignment_id = assignment_id

	 if @submission_id is null
		 begin
				insert into Flask_Learning_Management_System.dbo.[submission] default values
				set @media_file_id= cast(SCOPE_IDENTITY() as int)

				insert into Flask_Learning_Management_System.dbo.[submission_assignment]
				(
					student_id  ,
					assignment_id  ,
					submission_id
				)
				values
				(
					@student_id  ,
					@assignment_id  ,
					@submission_id
				)
		 end


	insert into Flask_Learning_Management_System.dbo.[submission_media_file]
	(
			submission_id,
			media_file_id
	)
	values
	(
			@submission_id,
			@media_file_id
	)

	select 'Assignment Submission Uplodated Successfully' as message, 200 as code
end



go

create proc  Flask_Schema.delete_submission
@actor_id int,
@submission_id int,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;

	
	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='SUBMISSION',
		@id=@submission_id,
		@target_role = 'STUDENT',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	if	exists(select * from Flask_Learning_Management_System.dbo.[user] where id = @actor_id and role = 'STUDENT')
		and
		not exists(select * from Flask_Learning_Management_System.dbo.[submission_assignment] where student_id = @actor_id and submission_id = @submission_id)

			begin
				set @error = 'You are not authorized to perform this action.'
				set @code = 403
				return 
			end

	delete from Flask_Learning_Management_System.dbo.[submission_assignment] 
	where @submission_id = submission_id

	while 1=1
	begin 

		if not exists(select * from Flask_Learning_Management_System.dbo.[submission_media_file] where submission_id = @submission_id)
			break


		declare  @media_file_id int

		select top(1) @media_file_id = media_file_id from Flask_Learning_Management_System.dbo.[submission_media_file]
		where submission_id = @submission_id

		delete from Flask_Learning_Management_System.dbo.[submission_media_file]
		where media_file_id = @media_file_id

		delete from Flask_Learning_Management_System.dbo.[media_file]
		where id = @media_file_id
	end

	delete from Flask_Learning_Management_System.dbo.[submission] 
	where @submission_id = id

	select 'Assignment Submission Deleted Successfully' as message, 200 as code
end


go


create proc  Flask_Schema.get_assignment_submission
@actor_id int,
@submission_id int ,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;

	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='SUBMISSION',
		@id=@submission_id,
		@target_role = 'ALL',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	if	exists(select * from Flask_Learning_Management_System.dbo.[user] where id = @actor_id and role = 'STUDENT')
		and
		not exists(select * from Flask_Learning_Management_System.dbo.[submission_assignment] where student_id = @actor_id and submission_id = @submission_id)

			begin
				set @error = 'You are not authorized to perform this action.'
				set @code = 403
				return 
			end


	-- get assignment submission media files
	
	select mf.*, s.submission_date from
	Flask_Learning_Management_System.dbo.[submission_media_file] as smf
	inner join
	Flask_Learning_Management_System.dbo.[media_file] as mf
	on smf.submission_id = @submission_id and mf.id = smf.media_file_id
	inner join
	Flask_Learning_Management_System.dbo.[submission] as s
	on s.id = @submission_id

end


go


create proc  Flask_Schema.get_assignment_submissions
@actor_id int,
@course_id int,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='COURSE',
		@id=@course_id,
		@target_role = 'INSTRUCTOR',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	-- get assignment submission media files
	
	select sa.*, s.submission_date from
	Flask_Learning_Management_System.dbo.[assignment] as assig
	inner join
	Flask_Learning_Management_System.dbo.[submission_assignment] as sa
	on assig.id = sa.assignment_id and assig.course_id = @course_id
	inner join
	Flask_Learning_Management_System.dbo.[submission] as s
	on s.id = sa.submission_id

end

go


create proc  Flask_Schema.add_submission_score
@actor_id int,
@submission_id int ,
@score float,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='SUBMISSION',
		@id=@submission_id,
		@target_role = 'INSTRUCTOR',
		@error = @error output,
        @code = @code output
	if @error is not null
		return


	if @score is null 
		begin
			set @error = 'Assignment score is required'
			set @code = 400
			return
		end

	if @score < 0.0 or @score > 1000
		begin
			set @error = 'Assignment score must be between 0 and 1000 values'
			set @code = 400
			return
		end
		
	declare @assignment_score int

	select @assignment_score = score from Flask_Learning_Management_System.dbo.[submission_assignment] where submission_id = @submission_id

	if @assignment_score is not null
		begin
			set @error = 'Assignment submission is already graded'
			set @code = 403
			return
		end

	update  Flask_Learning_Management_System.dbo.[submission_assignment]
		set score = @score
	where submission_id = @submission_id

	select 'Assignment Submission Graded Successfully' as message, 200 as code
end


go

create proc  Flask_Schema.update_submission_score
@actor_id int,
@submission_id int ,
@score float,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='SUBMISSION',
		@id=@submission_id,
		@target_role = 'INSTRUCTOR',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	if @score is null 
		begin
			set @error = 'Assignment score is required'
			set @code = 400
			return
		end

	if @score < 0.0 or @score > 1000
		begin
			set @error = 'Assignment score must be between 0 and 1000 values'
			set @code = 400
			return
		end
		
	declare @assignment_score int

	select @assignment_score = score from Flask_Learning_Management_System.dbo.[submission_assignment] where submission_id = @submission_id

	if @assignment_score is null
		begin
			set @error = 'Assignment submission has not graded yet'
			set @code = 403
			return
		end

	update  Flask_Learning_Management_System.dbo.[submission_assignment]
		set score = @score
	where submission_id = @submission_id

	select 'Assignment Submission Score Updated Successfully' as message, 200 as code
end

go


create proc  Flask_Schema.get_assignment_submission_score
@actor_id int,
@submission_id int ,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='SUBMISSION',
		@id=@submission_id,
		@target_role = 'ALL',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	if	exists(select * from Flask_Learning_Management_System.dbo.[user] where id = @actor_id and role = 'STUDENT')
		and
		not exists(select * from Flask_Learning_Management_System.dbo.[submission_assignment] where student_id = @actor_id and submission_id = @submission_id)

			begin
				set @error = 'You are not authorized to perform this action.'
				set @code = 403
				return 
			end

	-- get assignment submission media files
	
	select score  
	from Flask_Learning_Management_System.dbo.[submission_assignment]
	where 
	submission_id = @submission_id

end

go

create proc  Flask_Schema.get_assignment_submissions_scores
@actor_id int,
@course_id int,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='COURSE',
		@id=@course_id,
		@target_role = 'INSTRUCTOR',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	-- get assignment submission scores
	
	select sa.* from
	Flask_Learning_Management_System.dbo.[assignment] as assig
	inner join
	Flask_Learning_Management_System.dbo.[submission_assignment] as sa
	on assig.id = sa.assignment_id and assig.course_id = @course_id
end





































go


create proc  Flask_Schema.add_quiz
@actor_id int,
@course_id int ,
@title varchar(100) ,
@description varchar(1000),
@start_date datetime ,
@end_date datetime ,
@grade float ,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='COURSE',
		@id=@course_id,
		@target_role = 'INSTRUCTOR',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	-- Validate Quiz Attributes
	declare @min_duration int
	set @min_duration = (15)
	exec Flask_Schema.validate_assignment_quiz
	@title = @title,
	@description = @description ,
	@grade = @grade ,
	@start_date = @start_date  ,
	@min_duration = @min_duration,
	@end_date= @end_date  ,
	@error = @error output,
        @code = @code output	
	if @error is not null
		return 

	-- Insert New Quiz
	insert into Flask_Learning_Management_System.dbo.[quiz]
	(
			course_id,
			title,
			description,
			grade,
			start_date,
			end_date
	)
	values
	(
			@course_id ,
			@title ,
			@description,
			@grade,
			@start_date,
			@end_date
	)

	select 'Quiz Created Successfully' as message, 202 as code
end

go



create proc  Flask_Schema.update_quiz
@actor_id int,
@quiz_id int ,
@title varchar(100) ,
@description varchar(1000),
@start_date datetime ,
@end_date datetime ,
@grade float ,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='QUIZ',
		@id=@quiz_id,
		@target_role = 'INSTRUCTOR',
		@error = @error output,
        @code = @code output
	if @error is not null
		return


	-- Declare old values attributes
	declare		
		@old_title varchar(100) ,
		@old_description varchar(1000)  ,
		@old_language varchar(50),
		@old_start_date datetime ,
		@old_end_date datetime,
		@old_grade float


	-- Assign old values attributes
	select 
		@old_title = title,
		@old_description = description ,
		@old_grade = grade ,
		@old_start_date = start_date ,
		@old_end_date = end_date  
	from Flask_Learning_Management_System.dbo.[quiz]
	where id = @quiz_id


	-- Assing the old Value if the new value is null
	if @title is null
		set @title = @old_title

	if @description is null
		set @description = @old_description

	if @start_date is null
		set @start_date = @old_start_date

	if @end_date is null
		set @end_date = @old_end_date

	if @grade is null
		set @grade = @old_grade

	-- Validate new attributes
	declare @min_duration int
	set @min_duration = (15)
	exec Flask_Schema.validate_assignment_quiz
	@title = @title,
	@description = @description ,
	@grade = @grade ,
	@start_date = @start_date  ,
	@min_duration = @min_duration,
	@end_date= @end_date  ,
	@error = @error output,
    @code = @code output	
	if @error is not null
		return 
		
	-- Update quiz
	update Flask_Learning_Management_System.dbo.[quiz]
	set 
		title = @title,
		description = @description ,
		grade =  @grade ,
		start_date = @start_date ,
		end_date = @end_date  
	where id = @quiz_id

	select 'Quiz Updated Successfully' as message, 200 as code
end




go


create proc  Flask_Schema.delete_quiz
@actor_id int,
@quiz_id int ,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='QUIZ',
		@id=@quiz_id,
		@target_role = 'INSTRUCTOR',
		@error = @error output,
        @code = @code output
	if @error is not null
		return


	-- Delete quiz

	while 1=1
	begin 

		if not exists(select * from Flask_Learning_Management_System.dbo.[quiz_question] where quiz_id = @quiz_id)
			break


		declare  @question_id int

		select top(1) @question_id = question_id from Flask_Learning_Management_System.dbo.[quiz_question]
		where quiz_id = @quiz_id

		delete from Flask_Learning_Management_System.dbo.[quiz_question]
		where quiz_id = @quiz_id

		delete from Flask_Learning_Management_System.dbo.[question_choice]
		where question_id = @question_id

		delete from Flask_Learning_Management_System.dbo.[question]
		where id = @question_id
	end

	delete from Flask_Learning_Management_System.dbo.[quiz]
	where id = @quiz_id

	select 'Quiz Deleted Successfully' as message, 200 as code
end










go


create proc  Flask_Schema.get_quiz
@actor_id int,
@quiz_id int,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='QUIZ',
		@id=@quiz_id,
		@target_role = 'ALL',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	select * from Flask_Learning_Management_System.dbo.[quiz] where id = @quiz_id
end


go


create proc  Flask_Schema.get_quiz_questions
@actor_id int,
@quiz_id int,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='QUIZ',
		@id=@quiz_id,
		@target_role = 'ALL',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	select q.* from Flask_Learning_Management_System.dbo.[question] as q
	inner join
	Flask_Learning_Management_System.dbo.[quiz_question] as qq
	on qq.quiz_id = @quiz_id and qq.question_id = q.id

end

go


create proc  Flask_Schema.get_quiz_questions_choices
@actor_id int,
@quiz_id int,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='QUIZ',
		@id=@quiz_id,
		@target_role = 'ALL',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	select q.* from Flask_Learning_Management_System.dbo.[question] as q
	inner join
	Flask_Learning_Management_System.dbo.[quiz_question] as qq
	on qq.quiz_id = @quiz_id and qq.question_id = q.id
	inner join
	Flask_Learning_Management_System.dbo.[question_choice] as qc
	on qc.question_id = qq.question_id
end

go

create proc  Flask_Schema.get_quizzes
@actor_id int,
@course_id int,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='COURSE',
		@id=@course_id,
		@target_role = 'ALL',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	declare 
	@user_role varchar(10)
		
	select 
		@user_role = role
	from Flask_Learning_Management_System.dbo.[user]
	where id = @actor_id
	
	if @user_role ='STUDENT'
		begin
			select assig.title,assig.description,iif(subm.student_id IS NOT NULL, 1, 0) as submited
			from Flask_Learning_Management_System.dbo.[assignment] as assig
			left join
			Flask_Learning_Management_System.dbo.[submission_assignment] as subm
			on @actor_id = subm.student_id and assig.course_id = @course_id
			
			return
		end
	else
	begin
		select * from Flask_Learning_Management_System.dbo.[assignment] where course_id = @course_id
	end
end

go

create proc  Flask_Schema.add_quiz_question
@actor_id int,
@quiz_id int ,
@title varchar(100) ,
@correct_answer varchar(100) ,
@grade float , 
@type varchar(20),
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='QUIZ',
		@id=@quiz_id,
		@target_role = 'INSTRUCTOR',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	exec Flask_Schema.validate_question
		@title = @title,
		@correct_answer=@correct_answer,
		@grade = @grade,
		@type = @type,
		@error = @error output,
        @code = @code output
		if @error is not null
			return
	insert into Flask_Learning_Management_System.dbo.[question]
	(
		title ,
		correct_answer,
		grade , 
		type
	)
	values
	(
		@title ,
		@correct_answer,
		@grade , 
		@type
	)

	insert into Flask_Learning_Management_System.dbo.[quiz_question]
	(
	question_id,
	quiz_id
	)
	values
	(
	cast(SCOPE_IDENTITY() as int),
	@quiz_id
	)
	
	select 'Quiz Question Created Successfully' as message, 202 as code
end

go

create proc  Flask_Schema.update_quiz_question
@actor_id int,
@question_id int ,
@title varchar(100) ,
@correct_answer varchar(100) ,
@grade float , 
@type varchar(20),
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='QUIZ QUESTION',
		@id=@question_id,
		@target_role = 'INSTRUCTOR',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	-- Declare old values attributes
	declare		
		@old_title varchar(100) ,
		@old_correct_answer varchar(100) ,
		@old_grade float ,
		@old_type varchar(20)


	-- Assign old values attributes
	select 
		@old_title = title,
		@old_correct_answer = correct_answer ,
		@old_grade = grade ,
		@old_type = type 
	from Flask_Learning_Management_System.dbo.[question]
	where id = @question_id


	-- Assing the old Value if the new value is null
	if @title is null
		set @title = @old_title

	if @correct_answer is null
		set @correct_answer = @old_correct_answer

	if @grade is null
		set @grade = @old_grade

	if @type is null
		set @type = @old_type

	exec Flask_Schema.validate_question
		@title = @title,
		@correct_answer=@correct_answer,
		@grade = @grade,
		@type = @type,
		@error = @error output,
        @code = @code output
		if @error is not null
			return
	update Flask_Learning_Management_System.dbo.[question]
	set
		title = @title ,
		correct_answer = @correct_answer,
		grade= @grade  , 
		type = @type
	where id = @question_id	

	select 'Quiz Updated Successfully' as message, 200 as code
end


go


create proc  Flask_Schema.delete_quiz_question
@actor_id int,
@question_id int ,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='QUIZ QUESTION',
		@id=@question_id,
		@target_role = 'INSTRUCTOR',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	delete from Flask_Learning_Management_System.dbo.[question_choice]
	where question_id = @question_id

	delete from Flask_Learning_Management_System.dbo.[quiz_question]
	where question_id = @question_id

	delete from Flask_Learning_Management_System.dbo.[question]
	where id = @question_id

	select 'Quiz Deleted Successfully' as message, 200 as code
end

go


create proc  Flask_Schema.add_question_choice
@actor_id int,
@question_id int ,
@choice varchar(100),
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='QUIZ QUESTION',
		@id=@question_id,
		@target_role = 'INSTRUCTOR',
		@error = @error output,
        @code = @code output
	if @error is not null
		return


	-- Choice Validation
	exec Flask_Schema.is_valid_string 
		@attribute_name='Choice',
		@value = @choice,
		@max_length= 100 ,
		@allowed_null = 0,
		@error = @error output,
        @code = @code output
	if	@error is not null
		return

	insert into Flask_Learning_Management_System.dbo.[question_choice]
	(
		question_id,
		choice
	)
	values
	(
		@question_id,
		@choice
	)

	select 'Question Choice Created Successfully' as message, 202 as code
end

go

create proc  Flask_Schema.update_question_choice
@actor_id int,
@question_id int ,
@choice varchar(100),
@old_choice varchar(100),
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='QUIZ QUESTION',
		@id=@question_id,
		@target_role = 'INSTRUCTOR',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	
	-- Choice Validation
	exec Flask_Schema.is_valid_string 
		@attribute_name='Choice',
		@value = @choice,
		@max_length= 100 ,
		@allowed_null = 0,
		@error = @error output,
        @code = @code output
	if	@error is not null
		return
	-- Old Choice Validation
	exec Flask_Schema.is_valid_string 
		@attribute_name='Old Choice',
		@value = @old_choice,
		@max_length= 100 ,
		@allowed_null = 0,
		@error = @error output,
        @code = @code output
	if	@error is not null
		return

	if not exists(select * from Flask_Learning_Management_System.dbo.[question_choice] where choice = @old_choice and question_id = @question_id)
		begin
			set @error = 'Choice not found'
			set @code = 404
			return
		end 

	update Flask_Learning_Management_System.dbo.[question_choice]
		set
			choice = @choice
		where choice = @old_choice and @question_id = question_id

	select 'Question Choice Updated Successfully' as message, 200 as code
end


go


create proc  Flask_Schema.delete_question_choice
@actor_id int,
@question_id int ,
@choice varchar(100),
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


		exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='QUIZ QUESTION',
		@id=@question_id,
		@target_role = 'INSTRUCTOR',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	
	-- Choice Validation
	exec Flask_Schema.is_valid_string 
		@attribute_name='Choice',
		@value = @choice,
		@max_length= 100 ,
		@allowed_null = 0,
		@error = @error output,
        @code = @code output
	if	@error is not null
		return


	if not exists(select * from Flask_Learning_Management_System.dbo.[question_choice] where choice = @choice and question_id = @question_id)
		begin
			set @error = 'Choice not found'
			set @code = 404
			return
		end 

	delete from Flask_Learning_Management_System.dbo.[question_choice]
		where choice = @choice and @question_id = question_id

	select 'Question Choice Deleted Successfully' as message, 200 as code
end


go


create proc  Flask_Schema.add_bank_question
@actor_id int,
@course_id int ,
@title varchar(100) ,
@correct_answer varchar(100) ,
@grade float , 
@type varchar(20),
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


		exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='COURSE',
		@id=@course_id,
		@target_role = 'INSTRUCTOR',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	exec Flask_Schema.validate_question
		@title = @title,
		@correct_answer=@correct_answer,
		@grade = @grade,
		@type = @type,
		@error = @error output,
        @code = @code output
		if @error is not null
			return
	insert into Flask_Learning_Management_System.dbo.[question]
	(
		title ,
		correct_answer,
		grade , 
		type
	)
	values
	(
		@title ,
		@correct_answer,
		@grade , 
		@type
	)

	insert into Flask_Learning_Management_System.dbo.[bank_question]
	(
	question_id,
	course_id
	)
	values
	(
	cast(SCOPE_IDENTITY() as int),
	@course_id
	)
	
	select 'Bank Question Created Successfully' as message, 202 as code
end

go


create proc  Flask_Schema.add_quiz_question_from_bank
@actor_id int,
@quiz_id int,
@question_id int ,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


		exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='QUIZ',
		@id=@quiz_id,
		@target_role = 'INSTRUCTOR',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	declare @course_id int

	exec Flask_Schema.get_course_id 
		@type = 'QUIZ',
		@id = @quiz_id,
		@course_id = @course_id output

	if not exists(select * from Flask_Learning_Management_System.dbo.[bank_question] where course_id = @course_id and @question_id = question_id)
		begin
			set @error = 'Question Not Found'
			set @code = 404
			return
		end

	if  exists(select * from Flask_Learning_Management_System.dbo.[quiz_question] where quiz_id = @quiz_id and @question_id = question_id)
		begin
			set @error = 'Question is already existed'
			set @code = 403
			return
		end

	insert into Flask_Learning_Management_System.dbo.[quiz_question]
	(
		question_id,
		quiz_id
	)
	values
	(
		@question_id,
		@quiz_id
	)

	select 'Question Added Successfully To Quiz' as message, 200 as code
end


go


create proc  Flask_Schema.add_quiz_score
@quiz_id int,
@student_id int,
@score float,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@student_id,
		@type='QUIZ',
		@id=@quiz_id,
		@target_role = 'STUDENT',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	if exists(select * from Flask_Learning_Management_System.dbo.[quiz_score] where quiz_id = @quiz_id and @student_id = student_id and score is not null)
		begin
			set @error = 'Quiz is already graded'
			set @code = 403
			return
		end


	if @score < 0.0 or @score > 1000
	begin
		set @error = 'Quiz score must be between 0 and 1000 values'
		set @code = 400
		return
	end


	insert into  Flask_Learning_Management_System.dbo.[quiz_score]
	(
	quiz_id,
	student_id,
	score
	)
	values
	(
	@quiz_id,
	@student_id,
	@score
	)

	select 'Quiz Graded Successfully' as message, 200 as code
end
go


create proc  Flask_Schema.get_quiz_score
@actor_id int,
@quiz_id int,
@student_id int,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='QUIZ',
		@id=@quiz_id,
		@target_role = 'ALL',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	if not exists(select * from Flask_Learning_Management_System.dbo.[user] where id = @student_id and role = 'STUDENT')
		begin
			set @error = 'Student Not Found'
			set @code = 404
			return
		end

	exec Flask_Schema.check_security
		@actor_id=@student_id,
		@type='QUIZ',
		@id=@quiz_id,
		@target_role = 'STUDENT',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	if not exists(select * from Flask_Learning_Management_System.dbo.[quiz_score] where quiz_id = @quiz_id and @student_id = student_id and score is not null)
		begin
			set @error = 'Quiz has not graded yet'
			set @code = 403
			return
		end

	select score from Flask_Learning_Management_System.dbo.[quiz_score] where quiz_id = @quiz_id and @student_id = student_id
end


go


create proc  Flask_Schema.get_quizzes_scores
@actor_id int,
@course_id int,
@error varchar(100) output,
@code int output
as
begin
	set nocount on;

		exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='COURSE',
		@id=@course_id,
		@target_role = 'INSTRUCTOR',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	-- get quizzes scores
	
	select qs.* from
	Flask_Learning_Management_System.dbo.[course] as cour
	inner join
	Flask_Learning_Management_System.dbo.[quiz] as q
	on q.course_id = cour.id
	inner join
	Flask_Learning_Management_System.dbo.[quiz_score] as qs
	on qs.quiz_id = q.id
end


























go


go

create proc  Flask_Schema.add_notification
@course_id int,
@user_id int ,
@message varchar(500) ,
@error varchar(100) output,
@code int output 
as
begin
	set nocount on;
 

	exec Flask_Schema.check_security
		@actor_id=@user_id,
		@type='COURSE',
		@id=@course_id,
		@target_role = 'ALL',
		@error = @error output,
        @code = @code output
	if @error is not null
		return


	-- Message Validation
	exec Flask_Schema.is_valid_string 
		@attribute_name='Message',
		@value = @message,
		@max_length= 500 ,
		@min_length=10,
		@error = @error output,
        @code = @code output
	if	@error is not null
		return
	
	insert into Flask_Learning_Management_System.dbo.[notification]
	(
		course_id,
		user_id,
		message
	)
	values
	(
		@course_id,
		@user_id,
		@message
	)

	select 'Notification Created Successfully' as message, 202 as code
end

go

create proc  Flask_Schema.get_notification
@actor_id int,
@user_id int ,
@error varchar(100) output,
@code int output 
as
begin
	set nocount on;
 

	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='USER',
		@id=@user_id,
		@target_role = 'ALL',
		@error = @error output,
        @code = @code output
	if @error is not null
		return

	if not exists(select * from Flask_Learning_Management_System.dbo.[user] where id = @user_id and role != 'ADMIN')
		begin
			set @error = 'User must be instructor or student'
			set @code = 400
			return
		end


	update Flask_Learning_Management_System.dbo.[notification]
	set status = 'read'
	where user_id = @user_id


	select cour.title, n.message
	from Flask_Learning_Management_System.dbo.[notification] as n
	inner join
	Flask_Learning_Management_System.dbo.[course] as cour
	on cour.id = n.course_id and n.user_id = @user_id
	
end



















































go


create proc  Flask_Schema.add_course_category
@actor_id int,
@course_id int ,
@category varchar(100),
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='COURSE',
		@id=@course_id,
		@target_role = 'INSTRUCTOR',
		@error = @error output,
        @code = @code output
	if @error is not null
		return


	-- Category Validation
	exec Flask_Schema.is_valid_string 
		@attribute_name='Category',
		@value = @category,
		@max_length= 100 ,
		@min_length= 3,
		@allowed_null = 0,
		@error = @error output,
        @code = @code output
	if	@error is not null
		return

	if exists(select * from Flask_Learning_Management_System.dbo.[category] where course_id = @course_id and category = @category)
		begin
			set @error = 'Category is already existed'
			set @code = 403
			return
		end

	insert into Flask_Learning_Management_System.dbo.[category]
	(
		course_id,
		category
	)
	values
	(
		@course_id,
		@category
	)

	select 'Course Category Created Successfully' as message, 202 as code
end

go


create proc  Flask_Schema.update_course_category
@actor_id int,
@course_id int ,
@old_category varchar(100),
@category varchar(100),
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='COURSE',
		@id=@course_id,
		@target_role = 'INSTRUCTOR',
		@error = @error output,
        @code = @code output
	if @error is not null
		return


	-- Category Validation
	exec Flask_Schema.is_valid_string 
		@attribute_name='Category',
		@value = @category,
		@max_length= 100 ,
		@min_length= 3,
		@allowed_null = 0,
		@error = @error output,
        @code = @code output
	if	@error is not null
		return

	if not exists(select * from Flask_Learning_Management_System.dbo.[category] where course_id = @course_id and category = @old_category)
		begin
			set @error = 'Old Category Not Found'
			set @code = 404
			return
		end

	update Flask_Learning_Management_System.dbo.[category]
	set 
		category = @category
	where  course_id = @course_id and category = @old_category

	select 'Course Category Updated Successfully' as message, 200 as code
end


go

create proc  Flask_Schema.delete_course_category
@actor_id int,
@course_id int ,
@category varchar(100),
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='COURSE',
		@id=@course_id,
		@target_role = 'INSTRUCTOR',
		@error = @error output,
        @code = @code output
	if @error is not null
		return


	if not exists(select * from Flask_Learning_Management_System.dbo.[category] where course_id = @course_id and category = @category)
		begin
			set @error = 'Category Not Found'
			set @code = 404
			return
		end

	delete from Flask_Learning_Management_System.dbo.[category]
	where  course_id = @course_id and category = @category

	select 'Course Category Deleted Successfully' as message, 200 as code
end





































go



create proc  Flask_Schema.add_course_skill
@actor_id int,
@course_id int ,
@skill varchar(100),
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='COURSE',
		@id=@course_id,
		@target_role = 'INSTRUCTOR',
		@error = @error output,
        @code = @code output
	if @error is not null
		return


	-- Skill Validation
	exec Flask_Schema.is_valid_string 
		@attribute_name='Skill',
		@value = @skill,
		@max_length= 100 ,
		@min_length= 3,
		@allowed_null = 0,
		@error = @error output,
        @code = @code output
	if	@error is not null
		return

	if exists(select * from Flask_Learning_Management_System.dbo.[skill] where course_id = @course_id and skill = @skill)
		begin
			set @error = 'Skill is already existed'
			set @code = 403
			return
		end

	insert into Flask_Learning_Management_System.dbo.[skill]
	(
		course_id,
		skill
	)
	values
	(
		@course_id,
		@skill
	)

	select 'Course Skill Created Successfully' as message, 202 as code
end

go


create proc  Flask_Schema.update_course_skill
@actor_id int,
@course_id int ,
@old_skill varchar(100),
@skill varchar(100),
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='COURSE',
		@id=@course_id,
		@target_role = 'INSTRUCTOR',
		@error = @error output,
        @code = @code output
	if @error is not null
		return


	-- Skill Validation
	exec Flask_Schema.is_valid_string 
		@attribute_name='Skill',
		@value = @skill,
		@max_length= 100 ,
		@min_length= 3,
		@allowed_null = 0,
		@error = @error output,
        @code = @code output
	if	@error is not null
		return

	if not exists(select * from Flask_Learning_Management_System.dbo.[skill] where course_id = @course_id and skill = @old_skill)
		begin
			set @error = 'Old Skill Not Found'
			set @code = 404
			return
		end

	update Flask_Learning_Management_System.dbo.[skill]
	set 
		skill = @skill
	where  course_id = @course_id and skill = @old_skill

	select 'Course Skill Updated Successfully' as message, 200 as code
end


go

create proc  Flask_Schema.delete_course_skill
@actor_id int,
@course_id int ,
@skill varchar(100),
@error varchar(100) output,
@code int output
as
begin
	set nocount on;


	exec Flask_Schema.check_security
		@actor_id=@actor_id,
		@type='COURSE',
		@id=@course_id,
		@target_role = 'INSTRUCTOR',
		@error = @error output,
        @code = @code output
	if @error is not null
		return


	if not exists(select * from Flask_Learning_Management_System.dbo.[category] where course_id = @course_id and category = @skill)
		begin
			set @error = 'Skill Not Found'
			set @code = 404
			return
		end

	delete from Flask_Learning_Management_System.dbo.[category]
	where  course_id = @course_id and category = @skill

	select 'Course Skill Deleted Successfully' as message, 200 as code
end
