json.array! @connections do |connection|
  json.(connection, :sender_id, :receiver_id, :status)
end
