import pyodbc
from pyexpat.errors import messages

# Connection string
connection = pyodbc.connect(
    "DRIVER={ODBC Driver 17 for SQL Server};"
    "SERVER=Youssef-Shaban;"           # Or "localhost\SQLEXPRESS"
    "DATABASE=Flask_Learning_Management_System;"
    "UID=Flask_User;"
    "PWD=Flask_User@011211;"
)


def create_procedure(proc_name,names):
    inputs = [f"@{name} = ?" for name in names]
    inputs += ["@error = @error output"]
    inputs += ["@code = @code output"]
    inputs = ",\n".join(inputs)
    return f"""exec Flask_Schema.{proc_name}\n{inputs}"""

def execute_procedure(proc_name,names,data):
    procedure = create_procedure(proc_name,names)
    params = tuple([data.get(name) for name in names])
    return execute_query(procedure, params)


def create_query(procedure):
    query = "declare @error varchar(100),@code int \n" + procedure + "\n"
    error = "if @error is not null\n    select @error as error,@code as code"
    return query + error


def execute_query(procedure,params):
    query = create_query(procedure)
    cursor = connection.cursor()

    cursor.execute(query, params)

    try:
        if cursor.description is None:
            print("No result set returned.")
            response =  "No result set returned",500
        else:
            rows = cursor.fetchall()
            if not rows:
                print("Result set returned but it's empty.")
                response = "No result set returned",500
            else:
                # Get column names
                columns = [column[0] for column in cursor.description]
                # Combine headers with rows as dicts
                results = [dict(zip(columns, row)) for row in rows]

                if 'error' in columns :
                    print(results)
                    response = results[0]['error'],results[0]['code']
                elif 'message' in columns :
                    print(results)
                    response = results[0]['message'],results[0]['code']
                else:
                    response = results,200

    except Exception as e:
        response = str(e),500
        print(response)

    cursor.commit()
    cursor.close()

    return  response

