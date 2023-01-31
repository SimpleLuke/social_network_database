require 'user_repository'
require 'user'


def reset_users_table
  seed_sql = File.read('spec/seeds_social_network.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe UserRepository do
  before(:each) do 
    reset_users_table
  end

  # (your tests will go here).
  it 'returns all the users objects' do
    repo = UserRepository.new

    users = repo.all

    expect(users.length).to eq 2
    expect(users.first.id).to eq '1'
    expect(users.first.name).to eq 'David'
    expect(users.first.email).to eq 'david@gmail.com'
  end

  it 'returns a user object with a specific id' do
    repo = UserRepository.new

    user = repo.find(1)

    expect(user.id).to eq '1'
    expect(user.name).to eq 'David'
    expect(user.email).to eq 'david@gmail.com'
  end

  it 'creates a new user object' do
repo = UserRepository.new

    user = User.new
    user.name = 'Jenny'
    user.email = 'jenny@gmail.com'

    repo.create(user)
    all_users = repo.all

  expect(all_users.length).to eq 3
  expect(all_users.last.name).to eq 'Jenny'
    expect(all_users.last.email).to eq 'jenny@gmail.com'
  end

  it 'deletes a user from the database' do
    repo = UserRepository.new

  repo.delete(1)

  all_users = repo.all

  expect(all_users.length).to eq 1
  expect(all_users.last.name).to eq 'Jeo'
    expect(all_users.last.email).to eq 'joe@gmail.com'
  end

  it 'updates an user object data from the database' do
    repo = UserRepository.new

    user = repo.find(2) # => Jeo Object

    user.name = 'Joe'
    repo.update(user)
    update_user = repo.find(2)

    expect(update_user.id).to eq '2'
  expect(update_user.name).to eq 'Joe'
    expect(update_user.email).to eq 'joe@gmail.com'
  end
end
