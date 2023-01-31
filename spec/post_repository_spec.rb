require 'post_repository'
require 'post'


def reset_posts_table
  seed_sql = File.read('spec/seeds_social_network.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do 
    reset_posts_table
  end

  # (your tests will go here).
  it 'returns all the posts objects' do
    repo = PostRepository.new

    posts = repo.all

    expect(posts.length).to eq 1 
    expect(posts.first.id).to eq '1'
    expect(posts.first.title).to eq 'Learn to Code'
    expect(posts.first.content).to eq 'Coding is fun!'
  expect(posts.first.views).to eq '100'
  expect(posts.first.user_id).to eq '1'
  end

  it 'returns a post object with a specific id' do
    repo = PostRepository.new

    post = repo.find(1)

    expect(post.id).to eq '1'
    expect(post.title).to eq 'Learn to Code'
    expect(post.content).to eq 'Coding is fun!'
  expect(post.views).to eq '100'
  expect(post.user_id).to eq '1'
  end

  it 'creates a new post object' do
    repo = PostRepository.new

    post = Post.new
    post.title = 'Pair Programming'
    post.content = 'Pair is fun!'
    post.views = '500'
    post.user_id = '2'

    repo.create(post)
    all_posts = repo.all

    expect(all_posts.length).to eq 2
    expect(all_posts.last.title).to eq 'Pair Programming'
    expect(all_posts.last.content).to eq 'Pair is fun!'
  expect(all_posts.last.views).to eq '500'
  expect(all_posts.last.user_id).to eq '2'
  end

  xit 'deletes a post from the database' do
    repo = postReposxitory.new

    repo.delete(1)

    all_posts = repo.all

    expect(all_posts.length).to eq 1
    expect(all_posts.last.name).to eq 'Jeo'
    expect(all_posts.last.email).to eq 'joe@gmail.com'
  end

  xit 'updates an post object data from the database' do
    repo = postReposxitory.new

    post = repo.find(2) # => Jeo Object

    post.name = 'Joe'
    repo.update(post)
    update_post = repo.find(2)

    expect(update_post.id).to eq '2'
    expect(update_post.name).to eq 'Joe'
    expect(update_post.email).to eq 'joe@gmail.com'
  end
end
