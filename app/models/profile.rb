class Profile < ActiveRecord::Base

  validates :user, presence: :true
  
  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id,
    inverse_of: :profile
  )


end
