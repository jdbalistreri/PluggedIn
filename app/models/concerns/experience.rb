require 'action_view'

class Experience < ActiveRecord::Base
  include ActionView::Helpers::DateHelper

  enum experience_type: [:job, :school]

  validates :user, :experience_type, presence: true
  validates :start_date, presence: true

  validate :experience_type_specific_validations
  validate :dates_make_sense


  belongs_to(
    :user,
    inverse_of: :experiences
  )

  def type_str
    self.experience_type.to_s.capitalize
  end

  def date_string
    if self.job?
      start_str = self.start_date.strftime('%b %Y')
      end_str = self.end_date ? self.end_date.strftime('%b %Y') : "Present"
      distance = distance_of_time_in_words(self.start_date, self.end_date || Time.now)
      return "#{start_str} - #{end_str} (#{distance})"
    else
      start_str = self.start_date.strftime('%Y')
      end_str = self.end_date ? " - #{self.end_date.strftime('%Y')}" : ""
      return "#{start_str}#{end_str}"
    end
  end

  def start_year
    self.start_date.year
  end

  def start_month
    self.start_date.month
  end

  def end_year
    self.end_date && self.end_date.year
  end

  def end_month
    self.end_date && self.end_date.month
  end

  private
    def experience_type_specific_validations
      if !self.role.present?
        errors[:base] << (self.job? ? "Please enter a title." : "Degree can't be blank")
      end
      if !self.institution.present?
        errors[:base] << (self.job? ? "Please enter a company name." : "School can't be blank")
      end
    end

    def dates_make_sense
      return nil unless self.start_date
      if self.job?
        if self.start_date > Time.now
          errors[:base] << "Please enter a start date no later than this month."
        elsif self.end_date && self.end_date > Time.now
            errors[:base] << "Please enter an end date no later than this month."
        elsif self.end_date && self.start_date >= self.end_date
          errors[:base] << "Please be sure the start date is not after the end date."
        end
      else
      end

    end

end
