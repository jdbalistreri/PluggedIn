json.array! @connected_users do |user|
  json.partial! 'api/shared/user_simple', user: user
end
