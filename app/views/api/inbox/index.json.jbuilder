json.received_connections @received_connections do |connection|
  json.partial! 'api/connections/connection', user: connection.sender,
    connection: connection, sent: false
end

json.sent_connections @sent_connections do |connection|
  json.partial! 'api/connections/connection', user: connection.receiver,
    connection: connection, sent: true
end

json.sent_messages @sent_messages do |message|
  json.partial! 'api/messages/message', message: message , user: message.receiver, sent: true
end

json.received_messages @received_messages do |message|
  json.partial! 'api/messages/message', message: message , user: message.sender, sent: false
end
