class Experience < ActiveRecord::Base

  enum experience_type: [:job, :school]

  validate :experience_specific_validations
  validates :user, :experience_type, :location, presence: true
  validates :start_date, presence: true

  belongs_to(
    :user,
    inverse_of: :experiences
  )

  private
    def experience_specific_validations
      if self.role.empty?
        errors[:base] << (self.job? ? "Title can't be blank" : "Degree can't be blank")
      end
      if self.institution.empty?
        errors[:base] << (self.job? ? "Company can't be blank" : "School can't be blank")
      end
    end

end
