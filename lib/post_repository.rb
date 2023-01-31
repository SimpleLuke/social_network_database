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
  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, email FROM posts WHERE id = $1;
    sql = 'SELECT id, title, content, views, user_id FROM posts WHERE id = $1;'
    params = [id]

    result_set = DatabaseConnection.exec_params(sql,params)

    record = result_set[0]

    post = Post.new
    post.id = record['id']
    post.title = record['title'] 
    post.content = record['content']
    post.views = record['views']
    post.user_id = record['user_id']

    # Returns a single post object.
    return post
  end


  def create(post)
    sql = 'INSERT INTO posts (title, content, views, user_id) VALUES ($1, $2, $3, $4);'
    params = [post.title, post.content, post.views, post.user_id]

    DatabaseConnection.exec_params(sql,params)

    return nil
  end

  def update(post)
    sql = 'UPDATE posts SET title = $1, content = $2, views = $3, user_id = $4;'
    params = [post.title, post.content, post.views, post.user_id]

    DatabaseConnection.exec_params(sql,params)

    return nil
  end

  def delete(id)
    sql = 'DELETE FROM posts WHERE id = $1;'
    params = [id]

    DatabaseConnection.exec_params(sql,params)

    return nil
  end
end
