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
		set @existed = 1
		return
	set @existed = 0
		return
end
go 




create proc is_existed_and_authorized
@actor_id int,
@target_id int,
@error varchar(100) output
as 
begin
	declare 
	@existed int,
	@role varchar(10)

	exec is_user_existed @id=@actor_id,@existed = @existed
	exec get_role @id=@actor_id,@role = @role

	if @existed = 0
		begin
			set @error = 'You must be logged in to perform this action.'
			return
		end


	if @actor_id != @target_id and @role != 'ADMIN'
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end

	 exec is_user_existed @id=@target_id,@existed = @existed
	 if @existed = 0
		begin
			set @error = 'User Not Found'
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
	exec is_existed_and_authorized 
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
	exec is_existed_and_authorized 
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
	exec is_existed_and_authorized 
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
	declare 
	@existed int,
	@role varchar(10)

	exec is_user_existed @id=@actor_id,@existed = @existed
	exec get_role @id=@actor_id,@role = @role

	if @existed = 0
		begin
			set @error = 'You must be logged in to perform this action.'
			return
		end


	if @role != 'ADMIN'
		begin
			set @error = 'You are not authorized to perform this action.'
			return
		end


	select * from Flask_Learning_Management_System.dbo.[user]
end