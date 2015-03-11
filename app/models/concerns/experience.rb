require 'action_view'

class Experience < ActiveRecord::Base
  include ActionView::Helpers::DateHelper

  enum experience_type: [:job, :school]

  validate :experience_specific_validations
  validates :user, :experience_type, presence: true
  validates :start_date, presence: true

  belongs_to(
    :user,
    inverse_of: :experiences
  )

  def date_string
    if self.job?
      start_str = self.start_date.strftime('%b %Y')
      end_str = self.end_date ? self.end_date.strftime('%b %Y') : "Present"
      distance = distance_of_time_in_words(self.start_date, self.end_date || Time.now)
      return "#{start_str} - #{end_str} (#{distance})"
    else
      start_str = self.start_date.strftime('%Y')
      end_str = self.end_date ? self.end_date.strftime('%Y') : "Present"
      return "#{start_str} - #{end_str}"
    end
  end

  private
    def experience_specific_validations
      if !self.role.present?
        errors[:base] << (self.job? ? "Title can't be blank" : "Degree can't be blank")
      end
      if !self.institution.present?
        errors[:base] << (self.job? ? "Company can't be blank" : "School can't be blank")
      end
    end

end
