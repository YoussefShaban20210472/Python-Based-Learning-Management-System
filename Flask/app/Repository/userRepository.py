from app.database.connection import execute_procedure
def add_user(data):
    procedure_name = 'add_user'
    params = ('first_name', 'last_name', 'address', 'password', 'email', 'phone_number', 'birth_date', 'gender', 'role')
    return execute_procedure(procedure_name,params,data)
def login(data):
    procedure_name = 'user_login'
    params = ('password', 'email')
    return execute_procedure(procedure_name,params,data)


def get_all_users():
    return 'get_all_user',200

def get_user_by_id(id):
    return 'get_user_by_id',200


def update_user_by_id(id):
    return 'update_user_by_id',200

def delete_user_by_id(id):
    return 'delete_user_by_id',200


def get_me():
    return 'get_me',200

def update_me():
    return 'get_me',200

def delete_me():
    return 'get_me',200





def logout():
    return 'logout',200





# first_name = data.get('first_name')
    # last_name = data.get('last_name')
    # address = data.get('address')
    # password = data.get('password')
    # email =data.get('email')
    # phone_number = data.get('phone_number')
    # birth_date = data.get('birth_date')
    # gender = data.get('gender')
    # role =data.get('role')
    #
    # sql = """exec Flask_Schema.add_user
    #         @first_name = ?,
    #         @last_name = ?,
    #         @address = ?,
    #         @password = ?,
    #         @email = ?,
    #         @phone_number= ?,
    #         @birth_date = ?,
    #         @gender =?,
    #         @role =?,
    #         @error = @error output,
    #         @code = @code output
    # """
    #
    # params = (first_name, last_name, address, password, email, phone_number, birth_date, gender, role)
    #
    # return execute_query(sql, params)




    # password = data.get('password')
    # email =data.get('email')
    # sql = """exec Flask_Schema.user_login
    #            @password = ?,
    #            @email = ?,
    #            @error = @error output,
    #            @code = @code output
    #    """
    #
    # params = (password, email)
    #
    # return execute_query(sql, params)