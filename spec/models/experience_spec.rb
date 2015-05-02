require 'rails_helper'

describe Experience, type: :model do
  it "creates a valid experience" do
    experience = build(:experience)
    expect(experience.valid?).to be(true)
  end

  describe "general validations" do
    it "validates the presence of an user" do
      experience = build(:experience, user: nil)
      expect(experience.valid?).to be(false)
    end

    it "validates the presence of an experience type" do
      experience = build(:experience, experience_type: nil)
      expect(experience.valid?).to be(false)
    end

    it "validates the presence of a role" do
      experience = build(:experience, role: "")
      expect(experience.valid?).to be(false)
    end

    it "validates the presence of an institution" do
      experience = build(:experience, institution: "")
      expect(experience.valid?).to be(false)
    end

    it "validates the presence of a start date" do
      experience = build(:experience, start_date: nil)
      expect(experience.valid?).to be(false)
    end

    it "allows a null end date" do
      experience = build(:experience, end_date: nil)
      expect(experience.valid?).to be(true)
    end

    it "validates that the start date is no later than the present" do
      experience = build(:experience, start_date: Date.today + 1)
      expect(experience.valid?).to be(false)
    end

    it "validates that the start date is not after the end date" do
      experience = build(:experience, start_date: Date.today - 100, end_date: Date.today - 400)
      expect(experience.valid?).to be(false)
    end
  end

  describe "job-specific validations" do
    it "validates that the end date, if specified, is no later than the present" do
      experience = build(:experience, experience_type: :job, end_date: Date.today + 100)
      expect(experience.valid?).to be(false)
    end
  end

end
