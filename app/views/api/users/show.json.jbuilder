
json.(@user, :id, :fname, :lname, :location,
      :tagline, :industry, :date_of_birth, :summary)

json.jobs @user.experiences.where(experience_type: "job"), :id, :user_id, :experience_type,
  :role, :institution, :location, :description, :start_date, :end_date, :field

json.schools @user.experiences.where(experience_type: "school"), :id, :user_id, :experience_type,
  :role, :institution, :location, :description, :start_date, :end_date, :field
