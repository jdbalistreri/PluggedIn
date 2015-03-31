json.found @found
json.total_count @total_count

json.results @result_users do |user|
  json.partial! 'api/shared/user', user: user
end
