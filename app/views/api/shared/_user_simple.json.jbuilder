json.(user, :id, :fname, :lname, :full_name, :location,
      :tagline, :industry, :date_of_birth, :summary,
      :email)

json.thumb_picture_url image_url(user.picture.url(:thumb))
