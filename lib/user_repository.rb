require_relative './user.rb'

class UserRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, email FROM users; 
    users = []

    sql = 'SELECT id, name, email FROM users;'

    result_set = DatabaseConnection.exec_params(sql,[])

    result_set.each do |record|
      user = User.new
      user.id = record['id']
      user.name = record['name']
      user.email = record['email']
 
      users << user
    end
    # Returns an array of User objects.
    return users
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, email FROM users WHERE id = $1;
    sql = 'SELECT id, name, email FROM users WHERE id = $1;'
    params = [id]

    result_set = DatabaseConnection.exec_params(sql,params)

    record = result_set[0]

    user = User.new
    user.id = record['id']
    user.name = record['name']
    user.email = record['email']

    # Returns a single User object.
    return user
  end


  def create(user)
    sql = 'INSERT INTO users (name, email) VALUES ($1, $2);'
    params = [user.name,user.email]

    DatabaseConnection.exec_params(sql,params)

    return nil
  end

  def update(user)
    sql = 'UPDATE users SET name = $1, email = $2;'
    params = [user.name, user.email]

    DatabaseConnection.exec_params(sql,params)

    return nil
  end

  def delete(id)
    sql = 'DELETE FROM users WHERE id = $1;'
    params = [id]

    DatabaseConnection.exec_params(sql,params)

    return nil
  end
end
