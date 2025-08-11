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
			exec validate_dates
			@start_date=@start_date,
			@end_date = @end_date,
			@error = @error output

			if	@error is not null
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

	if not exists(select id from Flask_Learning_Management_System.dbo.[enrollment] where id = @course_id)
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

