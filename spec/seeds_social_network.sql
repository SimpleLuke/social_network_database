TRUNCATE TABLE users,posts RESTART IDENTITY; 
-- TRUNCATE TABLE posts RESTART IDENTITY;


INSERT INTO users (name, email) VALUES ('David', 'david@gmail.com');
INSERT INTO users (name, email) VALUES ('Jeo', 'joe@gmail.com');
INSERT INTO posts (title, content,views, user_id) VALUES ('Learn to Code', 'Coding is fun!','100' , '1')
