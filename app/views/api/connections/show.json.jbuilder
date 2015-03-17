json.partial! 'api/connections/connection',
  node_user_id: @connection.sender_id, connection: @connection, sent: true, user: @connection.receiver
