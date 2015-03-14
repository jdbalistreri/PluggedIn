json.array! @connected_users do |user|
  json.partial! 'api/shared/user', user: user
end
