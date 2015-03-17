
json.array! @received_messages do |message|
  json.partial! 'api/messages/message', message: message , user: message.sender
end
