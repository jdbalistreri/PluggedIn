class Experience < ActiveRecord::Base

  enum experience_type: [:employment, :education]

  validates :user, :experience_type, :start_date, presence: true

  belongs_to(
    :user,
    dependent: :destroy,
    inverse_of: :experiences
  )

end
