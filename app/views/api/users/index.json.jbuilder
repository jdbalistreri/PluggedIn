json.array! @users do |user|
  json.partial! 'api/shared/user_simple', user: user
end
