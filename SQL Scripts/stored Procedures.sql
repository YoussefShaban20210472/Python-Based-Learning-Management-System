create proc is_valid_string 
@attribute_name varchar(30),
@value varchar(500),
@max_length int,
@allowed_null int = 0,
@error varchar(100) output
as 
begin
	if @allowed_null = 1 and @value is null
		return
	if @value is null or len(@value) =0
	begin
		set @error= concat(@attribute_name ,' Is Required.')
		return
	end

	if len(@value) > @max_length
	begin
		set @error= concat(@attribute_name ,' Is Less Than Or Equal To ',@max_length,' Characters.')
		return
	end
end;

go;




create proc get_role 
@id int,@role varchar(10) output
as
begin
	select @role = role from Flask_Learning_Management_System.dbo.[user] where id=@id
	return
end

go;





create proc is_user_existed 
@id int,@existed int output
as
begin
	if exists(select * from Flask_Learning_Management_System.dbo.[user] where id=@id)
		begin
			set @existed = 1
			return
		end
	set @existed = 0
		return
end
go 



create proc is_existed_and_authorized
@id int,
@role varchar(10),
@exist_error_message varchar(100)= 'You must be logged in to perform this action.',
@role_error_message varchar(100)= 'You are not authorized to perform this action.',
@allowed_admin int = 0,
@error varchar(100) output

as 
begin
	declare 
	@existed int,
	@user_role varchar(10)

	exec is_user_existed 
	@id=@id,
	@existed = @existed output

	exec 
	get_role @id=@id,
	@role = @user_role output

	if @existed = 0
		begin
			set @error = @exist_error_message
			return
		end

	if   @allowed_admin = 1 and  @user_role = 'ADMIN'
		return

	if  @role != @user_role and @role != 'ALL'
		begin
			set @error = @role_error_message
			return
		end
end




go

create proc validate_user_security 
@actor_id int,
@target_id int,
@error varchar(100) output
as
begin
	
	declare 
	@existed int,
	@role varchar(10)

	exec is_user_existed 
	@id=@actor_id,
	@existed = @existed

	exec get_role 
	@id=@actor_id,
	@role = @role

	if @existed = 0
		begin
			set @error = 'You must be logged in to perform this action.'
			return
		end


	if @role != 'ADMIN' and @actor_id != @target_id
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end

	declare @target_id_exsited int

	exec is_user_existed 
	@id=@target_id ,
	@existed=@target_id_exsited output

	 if @target_id_exsited = 0
		begin
			set @error = 'User Not Found'
			return
		end
end

go
create proc validate_course_security 
@actor_id int,
@instructor_id int,
@error varchar(100) output
as
begin
	exec is_existed_and_authorized
	@id=@actor_id,
	@role='INSTRUCTOR',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return 

	declare @user_role varchar(10)
	exec get_role 
		@id=@actor_id,
		@role = @user_role output

	if @user_role ='ADMIN'
		begin
			exec is_existed_and_authorized
			@id=@actor_id,
			@role='INSTRUCTOR',
			@exist_error_message='Instructor id is not found',
			@role_error_message='Instructor id is not instructor ',
			@error=@error output
			if @error is not null
				return 
		end

	if (@user_role ='INSTRUCTOR' and @actor_id != @instructor_id) or @user_role ='STUDENT'
		begin
			set @error= 'You are not authorized to perform this action.'
			return
		end
end


go
create proc validate_user
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
@error varchar(100) output
as
begin
	-- First Name Validation
	exec is_valid_string 
		@attribute_name='First Name',
		@value = @first_name,
		@max_length= 30 ,
		@allowed_null = @allowed_null,
		@error = @error output
	if	@error is not null
		return

	-- Last Name Validation
	exec is_valid_string 
		@attribute_name='Last Name',
		@value = @last_name,
		@max_length= 30 ,
		@allowed_null = @allowed_null,
		@error = @error output
	if	@error is not null
		return

	-- Address Validation
	exec is_valid_string 
		@attribute_name='Address',
		@value = @address,
		@max_length= 200 ,
		@allowed_null = @allowed_null,
		@error = @error output
	if	@error is not null
		return

	-- Password Validation
	exec is_valid_string 
		@attribute_name='Password',
		@value = @password,
		@max_length= 500 ,
		@allowed_null = @allowed_null,
		@error = @error output
	if	@error is not null
		return

	-- Phone Number Validation
	exec is_valid_string 
		@attribute_name='Phone Number',
		@value = @phone_number,
		@max_length= 30 ,
		@allowed_null = @allowed_null,
		@error = @error output
	if	@error is not null
		return

	-- Gender Validation
	exec is_valid_string 
		@attribute_name='Gender',
		@value = @gender,
		@max_length= 10 ,
		@allowed_null = @allowed_null,
		@error = @error output
	if	@error is not null
		return
	
	if @gender is not null and @gender not in ('MALE', 'FEMALE')
	set @error = 'Gender Must Be MALE Or FEMALE'
	return

	-- Role Validation
	exec is_valid_string 
		@attribute_name='Role',
		@value = @role,
		@max_length= 10 ,
		@allowed_null = @allowed_null,
		@error = @error output
	if	@error is not null
		return
	
	if @role is not null and @role not in ('ADMIN','STUDENT','INSTRUCTOR')
		begin
			set @error = 'Role Must Be ADMIN, STUDENT, Or INSTRUCTOR'
			return
		end
	-- Birth Date Validation
	if @birth_date is null and @allowed_null = 0
		begin
			set @error = 'Birth Date is required.'
			return
		end
	if @birth_date is not null and datediff(year, @birth_date, getdate()) not between 18 and 80
		begin
			set @error = 'Age Must Be Between 18 And 80'
			return
		end

	-- Email Validation
	exec is_valid_string 
		@attribute_name='Email',
		@value = @email,
		@max_length= 100 ,
		@allowed_null = @allowed_null,
		@error = @error output
	if	@error is not null
		return

	if @email is not null and exists(select * from Flask_Learning_Management_System.dbo.[user] where email =@email)
		begin
			set @error = 'Email Address Is Already Taken'
			return
		end
end;

go;
create proc validate_dates
@start_date datetime,
@end_date datetime ,
@min_duration int,
@error varchar(100) output
as 
begin
	-- Start Date Validation
	if @start_date is null
		begin
			set @error= 'Start Date is required'
			return
		end
	if @start_date < cast(getdate() as date)
		begin
			set @error= 'Start Date must be in future or today'
			return
		end
	if @start_date > dateadd(year, 1, cast(getdate() as date))
		begin
			set @error= 'Start Date must not exceed one year from today.'
			return
		end

	-- End Date Validation
	if @end_date is null
		begin
			set @error= 'End Date is required'
			return
		end
	if @end_date <= @start_date
		begin
			set @error= 'End Date must be after Start Date'
			return
		end
	if @end_date > dateadd(year,1,@start_date)
		begin
			set @error= 'End Date must not exceed one year from Start Date.'
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
			return
		end
end

go
create proc validate_course
@title varchar(100),
@description varchar(1000)  ,
@language varchar(50),
@start_date datetime,
@end_date datetime ,
@allowed_null int = 0,
@error varchar(100) output
as
begin
	-- Title Validation
	exec is_valid_string 
		@attribute_name='Title',
		@value = @title,
		@max_length= 100 ,
		@allowed_null = @allowed_null,
		@error = @error output
	if	@error is not null
		return

	-- Description Validation
	exec is_valid_string 
		@attribute_name='Description',
		@value = @description,
		@max_length= 1000 ,
		@allowed_null = @allowed_null,
		@error = @error output
	if	@error is not null
		return

	-- Language Validation
	exec is_valid_string 
		@attribute_name='Language',
		@value = @language,
		@max_length= 50 ,
		@allowed_null = @allowed_null,
		@error = @error output
	if	@error is not null
		return

	-- Dates Validation
	if @allowed_null =0
		begin
			declare @min_duration int
			set @min_duration = (60 * 24 * 3)

			exec validate_dates
			@min_duration = @min_duration,
			@start_date=@start_date,
			@end_date = @end_date,
			@error = @error output

			if	@error is not null
			return
		end
	
end;





go

create proc validate_lesson
@title varchar(100),
@description varchar(1000),
@start_date datetime,
@end_date datetime ,
@otp varchar(500),
@allowed_null int = 0,
@error varchar(100) output
as
begin
	-- Title Validation
	exec is_valid_string 
		@attribute_name='Title',
		@value = @title,
		@max_length= 100 ,
		@allowed_null = @allowed_null,
		@error = @error output
	if	@error is not null
		return

	-- Description Validation
	exec is_valid_string 
		@attribute_name='Description',
		@value = @description,
		@max_length= 1000 ,
		@allowed_null = @allowed_null,
		@error = @error output
	if	@error is not null
		return

	-- Dates Validation
	if @allowed_null =0
		begin
			declare @min_duration int
			set @min_duration = (15)

			exec validate_dates
			@min_duration = @min_duration,
			@start_date=@start_date,
			@end_date = @end_date,
			@error = @error output

			if	@error is not null
			return
		end

	-- OTP Validation
	exec is_valid_string 
		@attribute_name='OTP',
		@value = @otp,
		@max_length= 500 ,
		@allowed_null = @allowed_null,
		@error = @error output
	if	@error is not null
		return
end;

go


create proc validate_assignment_quiz
@title varchar(100),
@description varchar(1000),
@start_date datetime,
@end_date datetime ,
@grade float,
@allowed_null int = 0,
@min_duration int,
@error varchar(100) output
as
begin
	-- Title Validation
	exec is_valid_string 
		@attribute_name='Title',
		@value = @title,
		@max_length= 100 ,
		@allowed_null = @allowed_null,
		@error = @error output
	if	@error is not null
		return

	-- Description Validation
	exec is_valid_string 
		@attribute_name='Description',
		@value = @description,
		@max_length= 1000 ,
		@allowed_null = @allowed_null,
		@error = @error output
	if	@error is not null
		return

	-- Dates Validation
	if @allowed_null =0
		begin

			exec validate_dates
			@min_duration = @min_duration,
			@start_date=@start_date,
			@end_date = @end_date,
			@error = @error output

			if	@error is not null
			return
		end

	-- Grade Validation
	if @grade is null
		begin
			set @error = 'Grade is required'
			return
		end
	if @grade < 0.0 or @grade > 1000
		begin
			set @error = 'Grade must be between 0 and 1000 values.'
			return
		end
end;

go
create proc add_user
@first_name varchar(30) ,
@last_name varchar(30) ,
@address varchar(200) ,
@password varchar(500) ,
@email varchar(100)  ,
@phone_number varchar(30)  ,
@birth_date date  ,
@gender varchar(10)  ,
@role varchar(10) ,
@error varchar(100) output
as
begin

	exec validate_user
	@first_name = @first_name,
	@last_name = @last_name ,
	@address = @address ,
	@password = @password ,
	@email = @email  ,
	@phone_number= @phone_number  ,
	@birth_date = @birth_date  ,
	@gender = @gender  ,
	@role = @role ,
	@error = @error  output
	
	if @error is not null
		return 

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
end;

go;

create proc validate_media_file
@path varchar(500),
@name varchar(100),
@extension varchar(100),
@allowed_null int = 0,
@error varchar(100) output
as
begin
	-- Path Validation
	exec is_valid_string 
		@attribute_name='Path',
		@value = @path,
		@max_length= 500 ,
		@allowed_null = @allowed_null,
		@error = @error output
	if	@error is not null
		return

	-- Name Validation
	exec is_valid_string 
		@attribute_name='Name',
		@value = @name,
		@max_length= 100 ,
		@allowed_null = @allowed_null,
		@error = @error output
	if	@error is not null
		return

	-- Extension Validation
	exec is_valid_string 
		@attribute_name='Extension',
		@value = @extension,
		@max_length= 100 ,
		@allowed_null = @allowed_null,
		@error = @error output
	if	@error is not null
		return
end;

go
create proc get_user
@actor_id int,
@target_id int,
@error varchar(100) output
as 
begin

	exec validate_user_security 
	@actor_id=@actor_id,
	@target_id=@target_id,
	@error=@error output
	if @error is not null
		return 
	select * from Flask_Learning_Management_System.dbo.[user] 
	where id = @target_id
end



go;

create proc delete_user
@actor_id int,
@target_id int,
@error varchar(100) output
as 
begin
	exec validate_user_security 
		@actor_id=@actor_id,
		@target_id=@target_id,
		@error=@error output
	if @error is not null
		return 

	delete from Flask_Learning_Management_System.dbo.[user]
		where id = @target_id
end


go;



create proc update_user
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
@error varchar(100) output
as
begin
	
	-- Check Existing and authorizing of users
	exec validate_user_security 
		@actor_id=@actor_id,
		@target_id=@target_id,
		@error=@error output
	if @error is not null
		return  


	-- Validate new attributes
	exec validate_user
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
	@error = @error  output
	
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
		
end;

go;



create proc user_login
@password varchar(500) ,
@email varchar(100) 
as 
begin
	select email, password from Flask_Learning_Management_System.dbo.[user]
	where email = @email and password = @password
end

go;

create proc get_users
@actor_id int,
@error varchar(100) output
as 
begin
	exec is_existed_and_authorized
	@id=@actor_id,
	@role='ADMIN',
	@error=@error output
	if @error is not null
		return 

	select * from Flask_Learning_Management_System.dbo.[user]
end



go




create proc add_course
@actor_id int,
@instructor_id int ,
@title varchar(100) ,
@description varchar(1000)  ,
@language varchar(50),
@start_date datetime ,
@end_date datetime ,
@error varchar(100) output
as
begin

	exec validate_course_security 
		@actor_id=@actor_id,
		@instructor_id=@instructor_id,
		@error=@error output
	if @error is not null
		return  

	exec validate_course
	@title = @title,
	@description = @description ,
	@language = @language ,
	@start_date = @start_date  ,
	@end_date= @end_date  ,
	@error = @error  output	
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
end;

go;



create proc update_course
@actor_id int,
@course_id int ,
@title varchar(100) ,
@description varchar(1000)  ,
@language varchar(50),
@start_date datetime ,
@end_date datetime ,
@error varchar(100) output
as
begin
	
	exec is_existed_and_authorized
	@id=@actor_id,
	@role='INSTRUCTOR',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return  

	if not exists(select id from Flask_Learning_Management_System.dbo.[course] where id = @course_id)
		begin
			set @error = 'Course Not Found'
			return
		end

	declare @instructor_id int
	select  @instructor_id = instructor_id from Flask_Learning_Management_System.dbo.[course] where id = @course_id

	exec validate_course_security 
	@actor_id=@actor_id,
	@instructor_id=@instructor_id,
	@error=@error output
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
	exec validate_course
	@title = @title,
	@description = @description ,
	@language = @language ,
	@start_date = @start_date  ,
	@end_date= @end_date  ,
	@error = @error  output	
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
end;


go


create proc delete_course
@actor_id int,
@course_id int ,
@error varchar(100) output
as
begin
	exec is_existed_and_authorized
	@id=@actor_id,
	@role='INSTRUCTOR',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return  

	if not exists(select id from Flask_Learning_Management_System.dbo.[course] where id = @course_id)
		begin
			set @error = 'Course Not Found'
			return
		end

	declare @instructor_id int
	select  @instructor_id = instructor_id from Flask_Learning_Management_System.dbo.[course] where id = @course_id

	exec validate_course_security 
	@actor_id=@actor_id,
	@instructor_id=@instructor_id,
	@error=@error output
	if @error is not null
		return

	delete from Flask_Learning_Management_System.dbo.[course]
	where id = @course_id

end


go


create proc get_course
@actor_id int,
@course_id int ,
@error varchar(100) output
as
begin
	exec is_existed_and_authorized
	@id=@actor_id,
	@role='ALL',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return

	if not exists(select id from Flask_Learning_Management_System.dbo.[course] where id = @course_id)
		begin
			set @error = 'Course Not Found'
			return
		end

	select 
		title,
		description,
		language,
		start_date,
		end_date  
	from Flask_Learning_Management_System.dbo.[course] where id = @course_id
end




go


create proc get_courses
@actor_id int,
@error varchar(100) output
as
begin
	exec is_existed_and_authorized
	@id=@actor_id,
	@role='ALL',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return

	select 
		title,
		description,
		language,
		start_date,
		end_date  
	from Flask_Learning_Management_System.dbo.[course]
end

go

create proc add_enrollment
@actor_id int,
@course_id int,
@student_id int,
@error varchar(100) output
as
begin
	exec is_existed_and_authorized
	@id=@actor_id,
	@role='STUDENT',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return

	if not exists(select id from Flask_Learning_Management_System.dbo.[course] where id = @course_id)
		begin
			set @error = 'Course Not Found'
			return
		end
	declare @user_role varchar(10)

	exec get_role 
	@id=@actor_id,
	@role = @user_role output

	if @actor_id != @student_id and @user_role != 'ADMIN'
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end

	if not exists(select id from Flask_Learning_Management_System.dbo.[user] where id = @student_id)
		begin
			set @error = 'Student Not Found'
			return
		end
	
	if  exists(select id from Flask_Learning_Management_System.dbo.[enrollment] where student_id = @student_id)
	begin
		set @error = 'Student is already enrolled'
		return
	end

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

end



go



create proc delete_enrollment
@actor_id int,
@enrollment_id int,
@error varchar(100) output
as
begin
	exec is_existed_and_authorized
	@id=@actor_id,
	@role='STUDENT',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return

	if not exists(select id from Flask_Learning_Management_System.dbo.[enrollment] where id = @enrollment_id)
		begin
			set @error = 'Enrollment Not Found'
			return
		end
	declare 
		@user_role varchar(10),
		@student_id int,
		@status varchar(20)

	select 
		@student_id=student_id,
		@status=status 
	from Flask_Learning_Management_System.dbo.[enrollment] where id = @enrollment_id

	exec get_role 
		@id=@actor_id,
		@role = @user_role output



	if @actor_id != @student_id and @user_role != 'ADMIN'
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end

	if @user_role = 'STUDENT' AND @status = 'REJECTED'
		begin
			set @error = 'You are not allowed to perform this action.'
			return
		end

	delete from Flask_Learning_Management_System.dbo.[enrollment] where id = @enrollment_id
end

go

create proc update_enrollment
@actor_id int,
@enrollment_id int,
@status varchar(20),
@error varchar(100) output
as
begin
	exec is_existed_and_authorized
	@id=@actor_id,
	@role='INSTRUCTOR',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return

	if not exists(select id from Flask_Learning_Management_System.dbo.[enrollment] where id = @enrollment_id)
		begin
			set @error = 'Enrollment Not Found'
			return
		end
	declare 
		@user_role varchar(10),
		@instructor_id int

	select 
		@instructor_id=cour.instructor_id
	from 
	Flask_Learning_Management_System.dbo.[enrollment] as enro
	INNER JOIN
	Flask_Learning_Management_System.dbo.[course] as cour
	on enro.course_id = cour.id


	exec get_role 
		@id=@actor_id,
		@role = @user_role output



	if @actor_id != @instructor_id and @user_role != 'ADMIN'
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end

	if @status is null or len(@status) = 0
		begin
			set @error = 'Status is required'
			return
		end

	if @status not in ('ACCEPTED','REJECTED')
	begin
		set @error = 'Status is not valid value'
		return
	end

	update Flask_Learning_Management_System.dbo.[enrollment] 
		set status = @status
	where id = @enrollment_id
end


go

create proc get_enrollment
@actor_id int,
@enrollment_id int,
@error varchar(100) output
as
begin
	exec is_existed_and_authorized
	@id=@actor_id,
	@role='ALL',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return

	if not exists(select id from Flask_Learning_Management_System.dbo.[enrollment] where id = @enrollment_id)
		begin
			set @error = 'Enrollment Not Found'
			return
		end
	declare 
		@user_role varchar(10),
		@student_id int,
		@instructor_id int
		

	select 
		@student_id=student_id
	from Flask_Learning_Management_System.dbo.[enrollment] where id = @enrollment_id


	select 
		@instructor_id=cour.instructor_id
	from 
	Flask_Learning_Management_System.dbo.[enrollment] as enro
	INNER JOIN
	Flask_Learning_Management_System.dbo.[course] as cour
	on enro.course_id = cour.id

	exec get_role 
		@id=@actor_id,
		@role = @user_role output



	if @actor_id != @student_id and  @actor_id != @instructor_id and @user_role != 'ADMIN'
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end

	select * from Flask_Learning_Management_System.dbo.[enrollment] where id = @enrollment_id
end

go

create proc get_enrollments
@actor_id int,
@course_id int,
@error varchar(100) output
as
begin
	exec is_existed_and_authorized
	@id=@actor_id,
	@role='INSTRUCTOR',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return

	if not exists(select id from Flask_Learning_Management_System.dbo.[course] where id = @course_id)
		begin
			set @error = 'Course Not Found'
			return
		end

	declare 
		@user_role varchar(10),
		@instructor_id int
		

	select 
		@instructor_id= instructor_id
	from 
	Flask_Learning_Management_System.dbo.[course]
	 where @course_id = id

	exec get_role 
		@id=@actor_id,
		@role = @user_role output



	if @actor_id != @instructor_id and @user_role != 'ADMIN'
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end

	select * from Flask_Learning_Management_System.dbo.[enrollment] where course_id = @course_id
end




go


create proc add_lesson
@actor_id int,
@course_id int ,
@title varchar(100) ,
@description varchar(1000),
@start_date datetime ,
@end_date datetime ,
@otp varchar(500) ,
@error varchar(100) output
as
begin

	exec is_existed_and_authorized
	@id=@actor_id,
	@role='INSTRUCTOR',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return

	if not exists(select id from Flask_Learning_Management_System.dbo.[course] where id = @course_id)
		begin
			set @error = 'Course Not Found'
			return
		end

	declare 
		@user_role varchar(10),
		@instructor_id int
		

	select 
		@instructor_id= instructor_id
	from 
	Flask_Learning_Management_System.dbo.[course]
	 where @course_id = id

	exec get_role 
		@id=@actor_id,
		@role = @user_role output



	if @actor_id != @instructor_id and @user_role != 'ADMIN'
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end

	exec validate_lesson
	@title = @title,
	@description = @description ,
	@otp = @otp ,
	@start_date = @start_date  ,
	@end_date= @end_date  ,
	@error = @error  output	
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
end

go



create proc update_lesson
@actor_id int,
@lesson_id int ,
@title varchar(100) ,
@description varchar(1000),
@start_date datetime ,
@end_date datetime ,
@otp varchar(500) ,
@error varchar(100) output
as
begin

	exec is_existed_and_authorized
	@id=@actor_id,
	@role='INSTRUCTOR',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return

	if not exists(select id from Flask_Learning_Management_System.dbo.[lesson] where id = @lesson_id)
		begin
			set @error = 'Lesson Not Found'
			return
		end

	declare 
		@user_role varchar(10),
		@instructor_id int
		

	select 
		@instructor_id= instructor_id
	from 
	Flask_Learning_Management_System.dbo.[course] as cour
	inner join
	Flask_Learning_Management_System.dbo.[lesson] as less
	 on less.course_id = cour.id and less.id = @lesson_id

	exec get_role 
		@id=@actor_id,
		@role = @user_role output



	if @actor_id != @instructor_id and @user_role != 'ADMIN'
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end

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
	exec validate_lesson
	@title = @title,
	@description = @description ,
	@otp = @otp,
	@start_date = @start_date  ,
	@end_date= @end_date  ,
	@error = @error  output	
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
end




go


create proc delete_lesson
@actor_id int,
@lesson_id int ,
@error varchar(100) output
as
begin

	exec is_existed_and_authorized
	@id=@actor_id,
	@role='INSTRUCTOR',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return

	if not exists(select id from Flask_Learning_Management_System.dbo.[lesson] where id = @lesson_id)
		begin
			set @error = 'Lesson Not Found'
			return
		end

	declare 
		@user_role varchar(10),
		@instructor_id int
		

	select 
		@instructor_id= instructor_id
	from 
	Flask_Learning_Management_System.dbo.[course] as cour
	inner join
	Flask_Learning_Management_System.dbo.[lesson] as less
	 on less.course_id = cour.id and less.id = @lesson_id

	exec get_role 
		@id=@actor_id,
		@role = @user_role output



	if @actor_id != @instructor_id and @user_role != 'ADMIN'
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end
		
	-- Delete lesson
	delete from Flask_Learning_Management_System.dbo.[lesson]
	where id = @lesson_id
end










go


create proc get_lesson
@actor_id int,
@lesson_id int,
@error varchar(100) output
as
begin
	exec is_existed_and_authorized
	@id=@actor_id,
	@role='ALL',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return

	if not exists(select id from Flask_Learning_Management_System.dbo.[lesson] where id = @lesson_id)
		begin
			set @error = 'Lesson Not Found'
			return
		end
	declare 
		@user_role varchar(10),
		@student_id int,
		@instructor_id int,
		@course_id int
		

	select 
		@instructor_id= instructor_id,
		@course_id= cour.id
	from 
	Flask_Learning_Management_System.dbo.[course] as cour
	inner join
	Flask_Learning_Management_System.dbo.[lesson] as less
	 on less.course_id = cour.id and less.id = @lesson_id


	

	exec get_role 
		@id=@actor_id,
		@role = @user_role output

	if @user_role ='STUDENT' and not exists(select id from Flask_Learning_Management_System.dbo.[enrollment] where student_id = @actor_id and course_id = @course_id )
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end

	if @actor_id != @instructor_id and @user_role != 'ADMIN'
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end
	if @user_role ='STUDENT'
		begin
			select less.title,less.description,iff(attend.student_id IS NOT NULL, 1, 0) as attended
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


create proc get_lessons
@actor_id int,
@course_id int,
@error varchar(100) output
as
begin
	exec is_existed_and_authorized
	@id=@actor_id,
	@role='ALL',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return

	if not exists(select id from Flask_Learning_Management_System.dbo.[course] where id = @course_id)
		begin
			set @error = 'Course Not Found'
			return
		end
	declare 
		@user_role varchar(10),
		@student_id int,
		@instructor_id int
		

	select 
		@instructor_id= instructor_id
	from 
	Flask_Learning_Management_System.dbo.[course] 
	 where  id = @course_id 


	

	exec get_role 
		@id=@actor_id,
		@role = @user_role output

	if @user_role ='STUDENT' and not exists(select id from Flask_Learning_Management_System.dbo.[enrollment] where student_id = @actor_id and course_id = @course_id)
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end

	if @actor_id != @instructor_id and @user_role != 'ADMIN'
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end

	if @user_role ='STUDENT'
		begin
			select less.title,less.description,iff(attend.student_id IS NOT NULL, 1, 0) as attended
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


create proc add_assignment
@actor_id int,
@course_id int ,
@title varchar(100) ,
@description varchar(1000),
@start_date datetime ,
@end_date datetime ,
@grade float not null ,
@error varchar(100) output
as
begin

	exec is_existed_and_authorized
	@id=@actor_id,
	@role='INSTRUCTOR',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return

	if not exists(select id from Flask_Learning_Management_System.dbo.[course] where id = @course_id)
		begin
			set @error = 'Course Not Found'
			return
		end

	declare 
		@user_role varchar(10),
		@instructor_id int
		

	select 
		@instructor_id= instructor_id
	from 
	Flask_Learning_Management_System.dbo.[course]
	 where @course_id = id

	exec get_role 
		@id=@actor_id,
		@role = @user_role output



	if @actor_id != @instructor_id and @user_role != 'ADMIN'
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end
	declare @min_duration int
	set @min_duration = (60 * 24)
	exec validate_assignment_quiz
	@title = @title,
	@description = @description ,
	@grade = @grade ,
	@start_date = @start_date  ,
	@min_duration = @min_duration,
	@end_date= @end_date  ,
	@error = @error  output	
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
end

go



create proc update_assignment
@actor_id int,
@assignment_id int ,
@title varchar(100) ,
@description varchar(1000),
@start_date datetime ,
@end_date datetime ,
@grade float ,
@error varchar(100) output
as
begin

	exec is_existed_and_authorized
	@id=@actor_id,
	@role='INSTRUCTOR',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return

	if not exists(select id from Flask_Learning_Management_System.dbo.[assignment] where id = @assignment_id)
		begin
			set @error = 'Assignment Not Found'
			return
		end

	declare 
		@user_role varchar(10),
		@instructor_id int
		

	select 
		@instructor_id= instructor_id
	from 
	Flask_Learning_Management_System.dbo.[course] as cour
	inner join
	Flask_Learning_Management_System.dbo.[assignment] as assig
	 on assig.course_id = cour.id and assig.id = @assignment_id

	exec get_role 
		@id=@actor_id,
		@role = @user_role output



	if @actor_id != @instructor_id and @user_role != 'ADMIN'
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end

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
	exec validate_assignment_quiz
	@title = @title,
	@description = @description ,
	@grade = @grade ,
	@start_date = @start_date  ,
	@min_duration = @min_duration,
	@end_date= @end_date  ,
	@error = @error  output	
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
end




go


create proc delete_assignment
@actor_id int,
@assignment_id int ,
@error varchar(100) output
as
begin

	exec is_existed_and_authorized
	@id=@actor_id,
	@role='INSTRUCTOR',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return

	if not exists(select id from Flask_Learning_Management_System.dbo.[assignment] where id = @assignment_id)
		begin
			set @error = 'Assignment Not Found'
			return
		end

	declare 
		@user_role varchar(10),
		@instructor_id int
		

	select 
		@instructor_id= instructor_id
	from 
	Flask_Learning_Management_System.dbo.[course] as cour
	inner join
	Flask_Learning_Management_System.dbo.[assignment] as assig
	 on assig.course_id = cour.id and assig.id = @assignment_id

	exec get_role 
		@id=@actor_id,
		@role = @user_role output



	if @actor_id != @instructor_id and @user_role != 'ADMIN'
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end
		
	-- Delete lesson
	delete from Flask_Learning_Management_System.dbo.[assignment]
	where id = @assignment_id
end










go


create proc get_assignment
@actor_id int,
@assignment_id int,
@error varchar(100) output
as
begin
	exec is_existed_and_authorized
	@id=@actor_id,
	@role='ALL',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return

	if not exists(select id from Flask_Learning_Management_System.dbo.[assignment] where id = @assignment_id)
		begin
			set @error = 'Assignment Not Found'
			return
		end
	declare 
		@user_role varchar(10),
		@student_id int,
		@instructor_id int,
		@course_id int
		

	select 
		@instructor_id= instructor_id,
		@course_id= cour.id
	from 
	Flask_Learning_Management_System.dbo.[course] as cour
	inner join
	Flask_Learning_Management_System.dbo.[assignment] as assig
	 on assig.course_id = cour.id and assig.id = @assignment_id


	

	exec get_role 
		@id=@actor_id,
		@role = @user_role output

	if @user_role ='STUDENT' and not exists(select id from Flask_Learning_Management_System.dbo.[enrollment] where student_id = @actor_id and course_id = @course_id )
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end

	if @actor_id != @instructor_id and @user_role != 'ADMIN'
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end
	if @user_role ='STUDENT'
		begin
			select assig.title,assig.description,iff(assig.student_id IS NOT NULL, 1, 0) as submited
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


create proc get_assignments
@actor_id int,
@course_id int,
@error varchar(100) output
as
begin
	exec is_existed_and_authorized
	@id=@actor_id,
	@role='ALL',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return

	if not exists(select id from Flask_Learning_Management_System.dbo.[course] where id = @course_id)
		begin
			set @error = 'Course Not Found'
			return
		end
	declare 
		@user_role varchar(10),
		@student_id int,
		@instructor_id int
		

	select 
		@instructor_id= instructor_id
	from 
	Flask_Learning_Management_System.dbo.[course] 
	 where  id = @course_id 


	

	exec get_role 
		@id=@actor_id,
		@role = @user_role output

	if @user_role ='STUDENT' and not exists(select id from Flask_Learning_Management_System.dbo.[enrollment] where student_id = @actor_id and course_id = @course_id)
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end

	if @actor_id != @instructor_id and @user_role != 'ADMIN'
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end

	if @user_role ='STUDENT'
		begin
			select assig.title,assig.description,iff(subm.student_id IS NOT NULL, 1, 0) as submited
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


create proc add_attendance
@actor_id int,
@student_id int,
@lesson_id int,
@otp varchar(500) ,
@error varchar(100) output
as
begin

	exec is_existed_and_authorized
	@id=@actor_id,
	@role='STUDENT',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return

	declare 
		@user_role varchar(10),
		@lesson_otp varchar(500),
		@course_id int
		


	exec get_role 
		@id=@actor_id,
		@role = @user_role output


	if @user_role ='ADMIN'
	begin
		exec is_existed_and_authorized
		@id=@actor_id,
		@role='STUDENT',
		@exist_error_message='Student id is not found',
		@role_error_message='Student id is not student ',
		@error=@error output
		if @error is not null
			return 
	end

	if @actor_id != @student_id and @user_role != 'ADMIN'
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end
	
	if not exists(select id from Flask_Learning_Management_System.dbo.[lesson] where id = @lesson_id)
	begin
		set @error = 'Lesson Not Found'
		return
	end

	select 
		@course_id= cour.id
	from 
	Flask_Learning_Management_System.dbo.[course] as cour
	inner join
	Flask_Learning_Management_System.dbo.[lesson] as assig
	 on assig.course_id = cour.id and assig.id = @lesson_id


	if not exists(select id from Flask_Learning_Management_System.dbo.[enrollment] where student_id = @actor_id and course_id = @course_id)
	begin
		if @user_role = 'STUDENT'
			set @error = 'You are not authorized to perform this action.'
		else
			set @error = 'Student is not enrolled to the course'
		return
	end

	if  exists(select id from Flask_Learning_Management_System.dbo.[attendance] where student_id = @actor_id and lesson_id = @lesson_id)
		begin
			if @user_role = 'STUDENT'
				set @error = 'You are already attended the lesson'
			else
				set @error = 'Student is already attended the lesson'
			return
		end

	-- OTP Validation
	exec is_valid_string 
		@attribute_name='OTP',
		@value = @otp,
		@max_length= 500 ,
		@error = @error output
	if	@error is not null
		return

	select @lesson_otp=otp from Flask_Learning_Management_System.dbo.[lesson] where id = @lesson_id

	if @lesson_otp != @otp
		begin
		set @error = 'OTP is not valid'
		end
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
end



go



create proc get_attendance
@actor_id int,
@attendance_id int,
@error varchar(100) output
as
begin
	exec is_existed_and_authorized
	@id=@actor_id,
	@role='ALL',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return

	if not exists(select id from Flask_Learning_Management_System.dbo.[attendance] where id = @attendance_id)
		begin
			set @error = 'Attendance Not Found'
			return
		end
	declare 
		@user_role varchar(10),
		@student_id int,
		@instructor_id int,
		@course_id int
		

	select 
		@instructor_id= instructor_id,
		@course_id= cour.id
	from 
	Flask_Learning_Management_System.dbo.[attendance] as attend
	inner join
	Flask_Learning_Management_System.dbo.[lesson] as less
	on attend.id = @attendance_id and less.id = attend.lesson_id
	inner join
	Flask_Learning_Management_System.dbo.[course] as cour
	 on less.course_id = cour.id


	

	exec get_role 
		@id=@actor_id,
		@role = @user_role output

	if @user_role ='STUDENT'
	   and 
	   (
		not exists(select id from Flask_Learning_Management_System.dbo.[enrollment] where student_id = @actor_id and course_id = @course_id )
		or
		not exists(select id from Flask_Learning_Management_System.dbo.[attendance] where student_id = @actor_id and id = @attendance_id)
	   )
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end

	if @actor_id != @instructor_id and @user_role != 'ADMIN'
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end

	if @user_role ='STUDENT'
		begin
			select iff(assig.student_id IS NOT NULL, 1, 0) as attended, attendance_date
			from Flask_Learning_Management_System.dbo.[attendance]
			where id = @attendance_id
			return
		end
	else
	begin
			select student_id, attendance_date
			from Flask_Learning_Management_System.dbo.[attendance]
			where id = @attendance_id
			return
	end
end



go



create proc get_attendances
@actor_id int,
@course_id int,
@error varchar(100) output
as
begin
exec is_existed_and_authorized
	@id=@actor_id,
	@role='INSTRUCTOR',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return

	if not exists(select id from Flask_Learning_Management_System.dbo.[course] where id = @course_id)
		begin
			set @error = 'Course Not Found'
			return
		end

	declare 
		@user_role varchar(10),
		@instructor_id int
		

	select 
		@instructor_id= instructor_id
	from 
	Flask_Learning_Management_System.dbo.[course]
	 where @course_id = id

	exec get_role 
		@id=@actor_id,
		@role = @user_role output



	if @actor_id != @instructor_id and @user_role != 'ADMIN'
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end

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


create proc add_course_media_file
@actor_id int,
@course_id int ,
@path varchar(500) not null,
@name varchar(100) not null,
@extension varchar(100) not null,
@error varchar(100) output
as
begin

	exec is_existed_and_authorized
	@id=@actor_id,
	@role='INSTRUCTOR',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return

	if not exists(select id from Flask_Learning_Management_System.dbo.[course] where id = @course_id)
		begin
			set @error = 'Course Not Found'
			return
		end

	declare 
		@user_role varchar(10),
		@instructor_id int
		

	select 
		@instructor_id= instructor_id
	from 
	Flask_Learning_Management_System.dbo.[course]
	 where @course_id = id

	exec get_role 
		@id=@actor_id,
		@role = @user_role output



	if @actor_id != @instructor_id and @user_role != 'ADMIN'
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end

	exec validate_media_file
	@path = @path,
	@name = @name ,
	@extension = @extension ,
	@error = @error  output	
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
end


go

create proc delete_course_media_file
@actor_id int,
@media_file_id int ,
@error varchar(100) output
as
begin

	exec is_existed_and_authorized
	@id=@actor_id,
	@role='INSTRUCTOR',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return

	if not exists(select media_file_id from Flask_Learning_Management_System.dbo.[course_media_file] where media_file_id = @media_file_id)
		begin
			set @error = 'File Not Found'
			return
		end

	declare 
		@user_role varchar(10),
		@instructor_id int
		

	select 
		@instructor_id= instructor_id
	from 
	Flask_Learning_Management_System.dbo.[course] as cour
	inner join
	Flask_Learning_Management_System.dbo.[course_media_file] as cmf
	 on cmf.media_file_id = @media_file_id and cour.id = cmf.course_id

	exec get_role 
		@id=@actor_id,
		@role = @user_role output



	if @actor_id != @instructor_id and @user_role != 'ADMIN'
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end
		
	-- Delete course media file
	delete from Flask_Learning_Management_System.dbo.[course_media_file]
	where media_file_id = @media_file_id

	delete from Flask_Learning_Management_System.dbo.[media_file]
	where id = @media_file_id
end










go


create proc get_course_media_file
@actor_id int,
@media_file_id int ,
@error varchar(100) output
as
begin

	exec is_existed_and_authorized
	@id=@actor_id,
	@role='ALL',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return

	if not exists(select media_file_id from Flask_Learning_Management_System.dbo.[course_media_file] where media_file_id = @media_file_id)
		begin
			set @error = 'File Not Found'
			return
		end

	declare 
		@user_role varchar(10),
		@instructor_id int,
		@course_id int
		

	select 
		@instructor_id= instructor_id,
		@course_id= course_id

	from 
	Flask_Learning_Management_System.dbo.[course] as cour
	inner join
	Flask_Learning_Management_System.dbo.[course_media_file] as cmf
	 on cmf.media_file_id = @media_file_id and cour.id = cmf.course_id

	exec get_role 
		@id=@actor_id,
		@role = @user_role output


	if @user_role ='STUDENT' and not exists(select id from Flask_Learning_Management_System.dbo.[enrollment] where student_id = @actor_id and course_id = @course_id )
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end

	if @actor_id != @instructor_id and @user_role != 'ADMIN'
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end
		
	-- get course media file

	select * from Flask_Learning_Management_System.dbo.[media_file]
	where id = @media_file_id
end

go


create proc get_course_media_files
@actor_id int,
@course_id int ,
@error varchar(100) output
as
begin
	exec is_existed_and_authorized
	@id=@actor_id,
	@role='ALL',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return

	if not exists(select id from Flask_Learning_Management_System.dbo.[course] where id = @course_id)
		begin
			set @error = 'Course Not Found'
			return
		end
	declare 
		@user_role varchar(10),
		@student_id int,
		@instructor_id int
		

	select 
		@instructor_id= instructor_id
	from 
	Flask_Learning_Management_System.dbo.[course] 
	 where  id = @course_id 


	

	exec get_role 
		@id=@actor_id,
		@role = @user_role output

	if @user_role ='STUDENT' and not exists(select id from Flask_Learning_Management_System.dbo.[enrollment] where student_id = @actor_id and course_id = @course_id)
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end

	if @actor_id != @instructor_id and @user_role != 'ADMIN'
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end

	-- get course media files
	select cmf.* 
	from Flask_Learning_Management_System.dbo.[course_media_file] as cmf
	inner join
	Flask_Learning_Management_System.dbo.[media_file] as mf
	on cmf.course_id = @course_id and mf.id = cmf.media_file_id
end

go

create proc add_submission
@actor_id int,
@student_id int,
@assignment_id int,
@path varchar(500) not null,
@name varchar(100) not null,
@extension varchar(100) not null,
@error varchar(100) output
as
begin

	exec is_existed_and_authorized
	@id=@actor_id,
	@role='STUDENT',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return

	declare 
		@user_role varchar(10),
		@lesson_otp varchar(500),
		@course_id int
		

	exec get_role 
		@id=@actor_id,
		@role = @user_role output


	if @user_role ='ADMIN'
		begin
			exec is_existed_and_authorized
			@id=@student_id,
			@role='STUDENT',
			@exist_error_message='Student id is not found',
			@role_error_message='Student id is not student ',
			@error=@error output
			if @error is not null
				return 
		end


	if @actor_id != @student_id and @user_role != 'ADMIN'
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end


	
	if not exists(select id from Flask_Learning_Management_System.dbo.[assignment] where id = @assignment_id)
	begin
		set @error = 'Assignment Not Found'
		return
	end

	select 
		@course_id= cour.id
	from 
	Flask_Learning_Management_System.dbo.[course] as cour
	inner join
	Flask_Learning_Management_System.dbo.[assignment] as assig
	 on assig.course_id = cour.id and assig.id = @assignment_id


	if not exists(select id from Flask_Learning_Management_System.dbo.[enrollment] where student_id = @student_id and course_id = @course_id)
	begin
		if @user_role = 'STUDENT'
			set @error = 'You are not authorized to perform this action.'
		else
			set @error = 'Student is not enrolled to the course'
		return
	end

	exec validate_media_file
	@path = @path,
	@name = @name ,
	@extension = @extension ,
	@error = @error  output	
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

end



go

create proc delete_submission
@actor_id int,
@submission_id int,
@error varchar(100) output
as
begin

	exec is_existed_and_authorized
	@id=@actor_id,
	@role='STUDENT',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return


	if not exists(select * from Flask_Learning_Management_System.dbo.[submission_assignment] where submission_id = @submission_id)
		begin
			set @error = 'Submission Not Found'
			return
		end

	declare 
		@user_role varchar(10),
		@student_id int,
		@course_id int
		

	exec get_role 
		@id=@actor_id,
		@role = @user_role output


	 select @student_id = student_id 
	 from Flask_Learning_Management_System.dbo.[submission_assignment] 
	 where  @submission_id = submission_id



	if @actor_id != @student_id and @user_role != 'ADMIN'
		begin
			set @error = 'You are not authorized to perform this action.'
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
end


go


create proc get_assignment_submission
@actor_id int,
@submission_id int ,
@error varchar(100) output
as
begin

	exec is_existed_and_authorized
	@id=@actor_id,
	@role='ALL',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return

	if not exists(select * from Flask_Learning_Management_System.dbo.[submission_assignment] where submission_id = @submission_id)
		begin
			set @error = 'Submission Not Found'
			return
		end

	declare 
		@user_role varchar(10),
		@instructor_id int,
		@course_id int,
		@student_id int


	 select @student_id = student_id 
	 from Flask_Learning_Management_System.dbo.[submission_assignment] 
	 where  @submission_id = submission_id
		

	select 
		@instructor_id= instructor_id,
		@course_id= course_id
	from 
	Flask_Learning_Management_System.dbo.[submission_assignment] as sa
	inner join
	Flask_Learning_Management_System.dbo.[assignment] as assig
	on sa.submission_id = @submission_id and assig.id = sa.assignment_id
	inner join
	Flask_Learning_Management_System.dbo.[course] as cour
	 on cour.id = assig.course_id

	exec get_role 
		@id=@actor_id,
		@role = @user_role output


	if @actor_id != @instructor_id and  @actor_id != @student_id  and @user_role != 'ADMIN'
		begin
			set @error = 'You are not authorized to perform this action.'
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


create proc get_assignment_submissions
@actor_id int,
@course_id int,
@error varchar(100) output
as
begin
exec is_existed_and_authorized
	@id=@actor_id,
	@role='INSTRUCTOR',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return

	if not exists(select id from Flask_Learning_Management_System.dbo.[course] where id = @course_id)
		begin
			set @error = 'Course Not Found'
			return
		end

	declare 
		@user_role varchar(10),
		@instructor_id int
		

	select 
		@instructor_id= instructor_id
	from 
	Flask_Learning_Management_System.dbo.[course]
	 where @course_id = id

	exec get_role 
		@id=@actor_id,
		@role = @user_role output



	if @actor_id != @instructor_id and @user_role != 'ADMIN'
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end

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


create proc add_submission_score
@actor_id int,
@submission_id int ,
@score float,
@error varchar(100) output
as
begin

	exec is_existed_and_authorized
	@id=@actor_id,
	@role='INSTRUCTOR',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return

	if not exists(select * from Flask_Learning_Management_System.dbo.[submission_assignment] where submission_id = @submission_id)
		begin
			set @error = 'Submission Not Found'
			return
		end

	declare 
		@user_role varchar(10),
		@instructor_id int,
		@course_id int
		

	select 
		@instructor_id= instructor_id,
		@course_id= course_id
	from 
	Flask_Learning_Management_System.dbo.[submission_assignment] as sa
	inner join
	Flask_Learning_Management_System.dbo.[assignment] as assig
	on sa.submission_id = @submission_id and assig.id = sa.assignment_id
	inner join
	Flask_Learning_Management_System.dbo.[course] as cour
	 on cour.id = assig.course_id

	exec get_role 
		@id=@actor_id,
		@role = @user_role output


	if @actor_id != @instructor_id   and @user_role != 'ADMIN'
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end

	if @score is null 
		begin
			set @error = 'Assignment score is required'
			return
		end

	if @score < 0.0 or @score > 1000
		begin
			set @error = 'Assignment score must be between 0 and 1000 values'
			return
		end
		
	declare @assignment_score int

	select @assignment_score = score from Flask_Learning_Management_System.dbo.[submission_assignment] where submission_id = @submission_id

	if @assignment_score is not null
		begin
			set @error = 'Assignment submission is already graded'
			return
		end

	update  Flask_Learning_Management_System.dbo.[submission_assignment]
		set score = @score
	where submission_id = @submission_id
end


go

create proc update_submission_score
@actor_id int,
@submission_id int ,
@score float,
@error varchar(100) output
as
begin

	exec is_existed_and_authorized
	@id=@actor_id,
	@role='INSTRUCTOR',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return

	if not exists(select * from Flask_Learning_Management_System.dbo.[submission_assignment] where submission_id = @submission_id)
		begin
			set @error = 'Submission Not Found'
			return
		end

	declare 
		@user_role varchar(10),
		@instructor_id int,
		@course_id int
		

	select 
		@instructor_id= instructor_id,
		@course_id= course_id
	from 
	Flask_Learning_Management_System.dbo.[submission_assignment] as sa
	inner join
	Flask_Learning_Management_System.dbo.[assignment] as assig
	on sa.submission_id = @submission_id and assig.id = sa.assignment_id
	inner join
	Flask_Learning_Management_System.dbo.[course] as cour
	 on cour.id = assig.course_id

	exec get_role 
		@id=@actor_id,
		@role = @user_role output


	if @actor_id != @instructor_id   and @user_role != 'ADMIN'
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end

	if @score is null 
		begin
			set @error = 'Assignment score is required'
			return
		end

	if @score < 0.0 or @score > 1000
		begin
			set @error = 'Assignment score must be between 0 and 1000 values'
			return
		end
		
	declare @assignment_score int

	select @assignment_score = score from Flask_Learning_Management_System.dbo.[submission_assignment] where submission_id = @submission_id

	if @assignment_score is null
		begin
			set @error = 'Assignment submission has not graded yet'
			return
		end

	update  Flask_Learning_Management_System.dbo.[submission_assignment]
		set score = @score
	where submission_id = @submission_id
end

go


create proc get_assignment_submission_score
@actor_id int,
@submission_id int ,
@error varchar(100) output
as
begin

	exec is_existed_and_authorized
	@id=@actor_id,
	@role='ALL',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return

	if not exists(select * from Flask_Learning_Management_System.dbo.[submission_assignment] where submission_id = @submission_id)
		begin
			set @error = 'Submission Not Found'
			return
		end

	declare 
		@user_role varchar(10),
		@instructor_id int,
		@course_id int,
		@student_id int


	 select @student_id = student_id 
	 from Flask_Learning_Management_System.dbo.[submission_assignment] 
	 where  @submission_id = submission_id
		

	select 
		@instructor_id= instructor_id,
		@course_id= course_id
	from 
	Flask_Learning_Management_System.dbo.[submission_assignment] as sa
	inner join
	Flask_Learning_Management_System.dbo.[assignment] as assig
	on sa.submission_id = @submission_id and assig.id = sa.assignment_id
	inner join
	Flask_Learning_Management_System.dbo.[course] as cour
	 on cour.id = assig.course_id

	exec get_role 
		@id=@actor_id,
		@role = @user_role output


	if @actor_id != @instructor_id and  @actor_id != @student_id  and @user_role != 'ADMIN'
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end
		
	-- get assignment submission media files
	
	select score  
	from Flask_Learning_Management_System.dbo.[submission_assignment]
	where 
	submission_id = @submission_id

end

go

create proc get_assignment_submissions_scores
@actor_id int,
@course_id int,
@error varchar(100) output
as
begin
exec is_existed_and_authorized
	@id=@actor_id,
	@role='INSTRUCTOR',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return

	if not exists(select id from Flask_Learning_Management_System.dbo.[course] where id = @course_id)
		begin
			set @error = 'Course Not Found'
			return
		end

	declare 
		@user_role varchar(10),
		@instructor_id int
		

	select 
		@instructor_id= instructor_id
	from 
	Flask_Learning_Management_System.dbo.[course]
	 where @course_id = id

	exec get_role 
		@id=@actor_id,
		@role = @user_role output



	if @actor_id != @instructor_id and @user_role != 'ADMIN'
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end

	-- get assignment submission scores
	
	select sa.* from
	Flask_Learning_Management_System.dbo.[assignment] as assig
	inner join
	Flask_Learning_Management_System.dbo.[submission_assignment] as sa
	on assig.id = sa.assignment_id and assig.course_id = @course_id
end


go


create proc add_quiz
@actor_id int,
@course_id int ,
@title varchar(100) ,
@description varchar(1000),
@start_date datetime ,
@end_date datetime ,
@grade float not null ,
@error varchar(100) output
as
begin

	exec is_existed_and_authorized
	@id=@actor_id,
	@role='INSTRUCTOR',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return

	if not exists(select id from Flask_Learning_Management_System.dbo.[course] where id = @course_id)
		begin
			set @error = 'Course Not Found'
			return
		end

	declare 
		@user_role varchar(10),
		@instructor_id int
		

	select 
		@instructor_id= instructor_id
	from 
	Flask_Learning_Management_System.dbo.[course]
	 where @course_id = id

	exec get_role 
		@id=@actor_id,
		@role = @user_role output



	if @actor_id != @instructor_id and @user_role != 'ADMIN'
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end

	declare @min_duration int
	set @min_duration = (15)
	exec validate_assignment_quiz
	@title = @title,
	@description = @description ,
	@grade = @grade ,
	@start_date = @start_date  ,
	@min_duration = @min_duration,
	@end_date= @end_date  ,
	@error = @error  output	
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
end

go



create proc update_quiz
@actor_id int,
@quiz_id int ,
@title varchar(100) ,
@description varchar(1000),
@start_date datetime ,
@end_date datetime ,
@grade float ,
@error varchar(100) output
as
begin

	exec is_existed_and_authorized
	@id=@actor_id,
	@role='INSTRUCTOR',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return

	if not exists(select id from Flask_Learning_Management_System.dbo.[quiz] where id = @quiz_id)
		begin
			set @error = 'Quiz Not Found'
			return
		end

	declare 
		@user_role varchar(10),
		@instructor_id int
		

	select 
		@instructor_id= instructor_id
	from 
	Flask_Learning_Management_System.dbo.[course] as cour
	inner join
	Flask_Learning_Management_System.dbo.[quiz] as quiz
	 on quiz.course_id = cour.id and quiz.id = @quiz_id

	exec get_role 
		@id=@actor_id,
		@role = @user_role output



	if @actor_id != @instructor_id and @user_role != 'ADMIN'
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end

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
	exec validate_assignment_quiz
	@title = @title,
	@description = @description ,
	@grade = @grade ,
	@start_date = @start_date  ,
	@min_duration = @min_duration,
	@end_date= @end_date  ,
	@error = @error  output	
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
end




go


create proc delete_quiz
@actor_id int,
@quiz_id int ,
@error varchar(100) output
as
begin

	exec is_existed_and_authorized
	@id=@actor_id,
	@role='INSTRUCTOR',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return

	if not exists(select id from Flask_Learning_Management_System.dbo.[quiz] where id = @quiz_id)
		begin
			set @error = 'Quiz Not Found'
			return
		end

	declare 
		@user_role varchar(10),
		@instructor_id int
		

	select 
		@instructor_id= instructor_id
	from 
	Flask_Learning_Management_System.dbo.[course] as cour
	inner join
	Flask_Learning_Management_System.dbo.[quiz] as quiz
	 on quiz.course_id = cour.id and quiz.id = @quiz_id

	exec get_role 
		@id=@actor_id,
		@role = @user_role output



	if @actor_id != @instructor_id and @user_role != 'ADMIN'
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end


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
end










go


create proc get_quiz
@actor_id int,
@quiz_id int,
@error varchar(100) output
as
begin
	exec is_existed_and_authorized
	@id=@actor_id,
	@role='ALL',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return

	if not exists(select id from Flask_Learning_Management_System.dbo.[quiz] where id = @quiz_id)
		begin
			set @error = 'Quiz Not Found'
			return
		end
	declare 
		@user_role varchar(10),
		@student_id int,
		@instructor_id int,
		@course_id int
		

	select 
		@instructor_id= instructor_id,
		@course_id= cour.id
	from 
	Flask_Learning_Management_System.dbo.[course] as cour
	inner join
	Flask_Learning_Management_System.dbo.[quiz] as quiz
	 on quiz.course_id = cour.id and quiz.id = @quiz_id


	

	exec get_role 
		@id=@actor_id,
		@role = @user_role output

	if @user_role ='STUDENT' and not exists(select id from Flask_Learning_Management_System.dbo.[enrollment] where student_id = @actor_id and course_id = @course_id )
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end

	if @actor_id != @instructor_id and @user_role != 'ADMIN'
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end
	select * from Flask_Learning_Management_System.dbo.[quiz] where id = @quiz_id
end


go


create proc get_quizzes
@actor_id int,
@course_id int,
@error varchar(100) output
as
begin
	exec is_existed_and_authorized
	@id=@actor_id,
	@role='ALL',
	@allowed_admin=1,
	@error=@error output
	if @error is not null
		return

	if not exists(select id from Flask_Learning_Management_System.dbo.[course] where id = @course_id)
		begin
			set @error = 'Course Not Found'
			return
		end
	declare 
		@user_role varchar(10),
		@student_id int,
		@instructor_id int
		

	select 
		@instructor_id= instructor_id
	from 
	Flask_Learning_Management_System.dbo.[course] 
	 where  id = @course_id 


	

	exec get_role 
		@id=@actor_id,
		@role = @user_role output

	if @user_role ='STUDENT' and not exists(select id from Flask_Learning_Management_System.dbo.[enrollment] where student_id = @actor_id and course_id = @course_id)
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end

	if @actor_id != @instructor_id and @user_role != 'ADMIN'
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end

	if @user_role ='STUDENT'
		begin
			select assig.title,assig.description,iff(subm.student_id IS NOT NULL, 1, 0) as submited
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