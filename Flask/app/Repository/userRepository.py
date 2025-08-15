from app.database.connection import execute_procedure

def add_user(data):
    procedure_name = 'add_user'
    params = ('first_name', 'last_name', 'address', 'password', 'email', 'phone_number', 'birth_date', 'gender', 'role')
    return execute_procedure(procedure_name,params,data)
def login(data):
    procedure_name = 'user_login'
    params = ('password', 'email')
    return execute_procedure(procedure_name,params,data)


def get_all_users(data):
    procedure_name = 'get_users'
    params = ('actor_id',)
    return execute_procedure(procedure_name,params,data)

def get_user_by_id(data):
    procedure_name = 'get_user'
    params = ('actor_id','target_id')
    return execute_procedure(procedure_name,params,data)


def update_user_by_id(data):
    procedure_name = 'update_user'
    params = ('actor_id','target_id','first_name', 'last_name', 'address', 'password', 'email', 'phone_number', 'birth_date', 'gender')
    return execute_procedure(procedure_name,params,data)

def delete_user_by_id(data):
    procedure_name = 'delete_user'
    params = ('actor_id','target_id')
    return execute_procedure(procedure_name,params,data)










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