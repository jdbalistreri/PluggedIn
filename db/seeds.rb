User.destroy_all
Experience.destroy_all

NUM_USERS = 100

# USER CREATION
(NUM_USERS).times do |i|
  user = User.make_user
end

User.all.each do |user|
  user.add_connections
end
