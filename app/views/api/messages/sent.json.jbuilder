
json.array! @sent_messages do |message|
  json.partial! 'api/messages/message', message: message , user: message.receiver
end
