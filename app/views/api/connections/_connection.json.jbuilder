json.(connection, :sender_id, :receiver_id, :status, :id, :created_at)
json.sent sent
json.user do
  json.partial! 'api/shared/user', user: user
end
