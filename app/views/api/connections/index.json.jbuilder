json.array! @connections do |connection|
  json.(connection, :sender_id, :receiver_id, :status)
  json.users connection.users do |user|
    next if user.id === @user.id
    json.partial! 'api/shared/user', user: user
  end
end
