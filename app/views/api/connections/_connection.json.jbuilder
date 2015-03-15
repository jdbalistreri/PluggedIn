json.(connection, :sender_id, :receiver_id, :status)
json.users connection.users do |user|
  next if user.id === node_user_id
  json.partial! 'api/shared/user', user: user
end
