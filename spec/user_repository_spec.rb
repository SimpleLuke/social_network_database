require 'user_repository'


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
end
