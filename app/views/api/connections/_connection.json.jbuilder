json.(connection, :sender_id, :receiver_id, :status, :id)
json.user do
  json.partial! 'api/shared/user', user: user
end
