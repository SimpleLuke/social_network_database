# Social Network Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here.

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE users RESTART IDENTITY; -- replace with your own table name.
TRUNCATE TABLE posts RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO users (name, email) VALUES ('David', 'david@gmail.com');
INSERT INTO posts (title, content,views, user_id) VALUES ('Learn to Code', 'Coding is fun!',100 , '1')
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: users

# Model class
# (in lib/users.rb)
class User
end

# Repository class
# (in lib/user_repository.rb)
class UserRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: users

# Model class
# (in lib/user.rb)

class User

  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :email
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
```

_You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed._

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: users

# Repository class
# (in lib/user_repository.rb)

class UserRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, email FROM users;

    # Returns an array of User objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, email FROM users WHERE id = $1;

    # Returns a single User object.
  end


  def create(user)
  end

  def update(user)
  end

  def delete(user)
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Return all users

repo = UserRepository.new

users = repo.all

users.length # => 2

users.first.id # => 1
users.first.name # => David
users.first.email # => david@gmail.com
# 2
# Get a single user

repo = UserRepository.new

user = repo.find(1)

user.id # =>  1
user.name # =>  'David'
user.email # =>  'david@gmail.com'

# 3
# create a new user object
repo = UserRepository.new

repo.create(user)

all_users = repo.all

all_users.length # => 3
all_users.last.name #=> 'Jenny'
all_users.last.email # => 'jenny@gmail.com'

# 4
# delete a user from the database
repo = UserRepository.new

repo.delete(1)

all_users = repo.all

all_users.length # => 1
all_users.last.name #=> 'Jeo'
all_users.last.email # => 'jeo@gmail.com'

# 5
# Update user data from the database

repo = UserRepository.new

user = repo.find(2) # => Jeo Object

user.name = 'Joe'
repo.update(user)
update_user = repo.find(2)

update_user.id # => 2
update_user.name #=> 'Joe'
update_user.email #=> 'joe@gmail.com'







```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do
    reset_students_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

**How was this resource?**  
[😫](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😫) [😕](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😕) [😐](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😐) [🙂](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=🙂) [😀](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😀)  
Click an emoji to tell us.

<!-- END GENERATED SECTION DO NOT EDIT -->
