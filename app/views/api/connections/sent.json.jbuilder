json.array! @sent_connections do |connection|
  json.partial! 'api/connections/connection', user: connection.receiver, connection: connection
end
