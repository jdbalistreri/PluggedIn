require 'rails_helper'


describe Experience, type: :model do
  let(:user) { User.new(email: "user@example.com", password: "password")}

  it "validates the presence of an user" do
    experience1 = user.experiences.new(
                    {start_date: Date.new(2000,1,1),
                      experience_type: 0})
    expect(experience1.valid?).to be(true)

    experience2 = Experience.new(
                    {start_date: Date.new(2000,1,1),
                      experience_type: 0})
    expect(experience2.valid?).to be(false)
  end

  it "validates the presence of a start date and experience type" do
    experience1 = user.experiences.new(start_date: Date.new(2000,1,1))
    expect(experience1.valid?).to be(false)

    experience2 = user.experiences.new(experience_type: 1)
    expect(experience2.valid?).to be(false)
  end

end
