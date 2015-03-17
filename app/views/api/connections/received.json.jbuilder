json.array! @received_connections do |connection|
  json.partial! 'api/connections/connection', user: connection.sender, connection: connection
end
