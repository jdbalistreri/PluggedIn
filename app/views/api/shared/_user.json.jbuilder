json.(user, :id, :fname, :lname, :full_name, :location,
      :tagline, :industry, :date_of_birth, :summary,
      :email)

json.cu_connected_with current_user.connected_with?(user)
json.cu_requested_user current_user.requested?(user)
json.cu_connection_status current_user.connection_status(user)

json.cu_connection user.connection_with(current_user)

json.profile_picture_url image_url(user.picture.url(:profile))
json.thumb_picture_url image_url(user.picture.url(:thumb))
