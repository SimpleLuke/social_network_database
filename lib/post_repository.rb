require_relative './post.rb'

class PostRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, email FROM posts; 
    posts = []

    sql = 'SELECT id, title, content, views, user_id FROM posts;'

    result_set = DatabaseConnection.exec_params(sql,[])

    result_set.each do |record|
      post = Post.new
      post.id = record['id']
      post.title = record['title'] 
      post.content = record['content']
      post.views = record['views']
      post.user_id = record['user_id']
      posts << post
    end
    # Returns an array of post objects.
    return posts
  end
  #
  # # Gets a single record by its ID
  # # One argument: the id (number)
  # def find(id)
  #   # Executes the SQL query:
  #   # SELECT id, name, email FROM posts WHERE id = $1;
  #   sql = 'SELECT id, name, email FROM posts WHERE id = $1;'
  #   params = [id]
  #
  #   result_set = DatabaseConnection.exec_params(sql,params)
  #
  #   record = result_set[0]
  #
  #   post = User.new
  #   post.id = record['id']
  #   post.name = record['name']
  #   post.email = record['email']
  #
  #   # Returns a single post object.
  #   return post
  # end
  #
  #
  # def create(post)
  #   sql = 'INSERT INTO posts (name, email) VALUES ($1, $2);'
  #   params = [post.name,user.email]
  #
  #   DatabaseConnection.exec_params(sql,params)
  #
  #   return nil
  # end
  #
  # def update(post)
  #   sql = 'UPDATE posts SET name = $1, email = $2;'
  #   params = [post.name, user.email]
  #
  #   DatabaseConnection.exec_params(sql,params)
  #
  #   return nil
  # end
  #
  # def delete(id)
  #   sql = 'DELETE FROM posts WHERE id = $1;'
  #   params = [id]
  #
  #   DatabaseConnection.exec_params(sql,params)
  #
  #   return nil
  # end
end