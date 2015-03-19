
json.extract! message, :id, :sender_id, :subject, :body, :reply_to_id, :date_string, :created_at
json.sent sent
json.user do
  json.partial! 'api/shared/user', user: user
end
