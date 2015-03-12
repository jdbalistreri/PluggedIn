json.partial! 'api/shared/user', user: @user

json.picture_url image_url(@user.picture.url)


json.jobs @user.jobs do |job|
  json.partial! 'api/shared/experience', experience: job
end

json.schools @user.schools do |school|
  json.partial! 'api/shared/experience', experience: school
end
