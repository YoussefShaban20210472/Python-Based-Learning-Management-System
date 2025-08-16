from app.database.connection import execute_procedure
from app.Repository.storedProcedures import stored_procedures


def get_procedure(function_name):
    procedure_name = stored_procedures[function_name]['procedure_name']
    params = stored_procedures[function_name]['params']
    return procedure_name, params

def execute(function_name, data):
    (procedure_name,params) = get_procedure(function_name)
    return execute_procedure(procedure_name,params,data)


#
# def login(data):
#     (procedure_name,params) = get_procedure(inspect.currentframe().f_code.co_name)
#     return execute_procedure(procedure_name,params,data)
#
#
# def get_all_users(data):
#     (procedure_name,params) = get_procedure(inspect.currentframe().f_code.co_name)
#     return execute_procedure(procedure_name,params,data)
#
# def get_user_by_id(data):
#     (procedure_name,params) = get_procedure(inspect.currentframe().f_code.co_name)
#     return execute_procedure(procedure_name,params,data)
#
#
# def update_user_by_id(data):
#     (procedure_name,params) = get_procedure(inspect.currentframe().f_code.co_name)
#     return execute_procedure(procedure_name,params,data)
#
# def delete_user_by_id(data):
#     (procedure_name,params) = get_procedure(inspect.currentframe().f_code.co_name)
#     return execute_procedure(procedure_name,params,data)
#
#
#
#
#
#




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