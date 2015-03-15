json.array! @connection do |connection|
  connection.extract! :id
  json.users connection.users do |user|
    next if user.id === @user.id
    json.partial! 'api/shared/user', user: user
  end
end
