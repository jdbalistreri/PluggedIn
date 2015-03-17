
json.extract! message, :id, :sender_id, :subject, :body, :reply_to_id
json.user do
  json.partial! 'api/shared/user', user: user
end
