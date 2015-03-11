class Experience < ActiveRecord::Base

  enum experience_type: [:job, :school]

  validates :user, :experience_type, :start_date,
    :institution, :role, :location, presence: true

  belongs_to(
    :user,
    dependent: :destroy,
    inverse_of: :experiences
  )

end
