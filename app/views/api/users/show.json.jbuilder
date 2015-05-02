json.partial! 'api/shared/user_simple', user: @user

json.(@user, :num_connections, :education, :current_jobs, :previous_jobs)
json.profile_picture_url image_url(@user.picture.url(:profile))

json.jobs @user.jobs do |job|
  json.partial! 'api/shared/experience', experience: job
end

json.schools @user.schools do |school|
  json.partial! 'api/shared/experience', experience: school
end
