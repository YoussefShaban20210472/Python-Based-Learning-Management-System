USE Flask_Learning_Management_System


create login Flask_User WITH PASSWORD = 'Flask_User@011211';


create user Flask_User for login Flask_User;


deny select, insert, update, delete to Flask_User;


grant execute on schema::Flask_Schema to Flask_User;

