json.array! @connections do |connection|
  json.partial! 'api/connections/connection',
    node_user_id: @user.id, connection: connection, sent: true
end
