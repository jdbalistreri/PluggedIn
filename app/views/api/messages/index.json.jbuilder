
json.received_messages @received_messages do |message|
  json.extract! message, :id, :sender_id, :subject, :body, :reply_to_id
  json.sender do
    json.partial! 'api/shared/user', user: message.sender
  end
end

json.sent_messages @sent_messages do |message|
  json.extract! message, :id, :receiver_id, :subject, :body, :reply_to_id
  json.receiver do
    json.partial! 'api/shared/user', user: message.receiver
  end
end
