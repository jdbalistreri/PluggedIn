json.(user, :id, :fname, :lname, :full_name, :location,
      :tagline, :industry, :date_of_birth, :summary,
      :email, :num_connections)

json.num_shared_connections user.num_shared_connections_with(current_user)
json.cu_connection user.connection_with(current_user)

json.profile_picture_url image_url(user.picture.url(:profile))
json.thumb_picture_url image_url(user.picture.url(:thumb))
