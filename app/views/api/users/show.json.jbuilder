
json.(@user, :id, :fname, :lname, :location,
      :tagline, :industry, :date_of_birth, :summary)

json.jobs @user.jobs, :id, :user_id, :experience_type,
  :role, :institution, :location, :description, :start_date, :end_date,
  :date_string, :field

json.schools @user.schools, :id, :user_id, :experience_type,
  :role, :institution, :location, :description, :start_date, :end_date,
  :date_string, :field
