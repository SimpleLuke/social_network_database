require_relative 'lib/database_connection'
require_relative 'lib/user_repository'


# We need to give the database name to the method `connect`.
DatabaseConnection.connect('social_network')

user_repo = UserRepository.new

users = user_repo.all


users.each do |user|
  puts "#{user.name} - #{user.email}"
end
