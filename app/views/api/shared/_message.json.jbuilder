
json.extract! message, :id, :sender_id, :subject, :body, :reply_to_id, :date_string, :created_at, :body_preview
json.sent sent
json.user do
  json.partial! 'api/shared/user_simple', user: user
end
