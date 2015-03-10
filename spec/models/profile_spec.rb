require 'rails_helper'


describe Profile, type: :model do

  it "validates the presence of a user" do
    user = User.create(email: "user@example.com", password: "")
    profile1 = user.build_profile()
    expect(profile1).to be_valid

    profile2 = Profile.new()
    expect(profile2.valid?).to be(false)
  end

  it "has one user" do
    user = User.create(email: "user@example.com", password: "")
    profile1 = user.build_profile()
    expect(profile1.user.id).to eq(user.id)
  end

end
