require 'rails_helper'

describe User, type: :model do

  it "creates a valid user" do
    user = build(:user)
    expect(user.valid?).to be(true)
  end

  it "ensures a session token upon user creation" do
    user = build(:user)
    expect(user.session_token).not_to be(nil)
  end

  it "validates the presence of a password" do
    user = build(:user, password: "")
    expect(user.valid?).to be(false)
  end

  it "validates the presence of an email" do
    user = build(:user, email: "")
    expect(user.valid?).to be(false)
  end

  it "validates the presence of an fname" do
    user = build(:user, fname: "")
    expect(user.valid?).to be(false)
  end

  it "validates the presence of an lname" do
    user = build(:user, lname: "")
    expect(user.valid?).to be(false)
  end

  it "validates that users have a unique email address" do
    user1 = create(:user, email: "user@example.com")
    user2 = build(:user, email: "user@example.com")
    expect(user2.valid?).to be(false)
  end

  it "finds a user by username and password" do
    user = create(:user, email: "user@example.com", password: "password")
    found_user = User.find_by_credentials("user@example.com", "password")
    expect(user.id).to equal(found_user.id)
  end

  it "does not save a user's password" do
    user = create(:user)
    expect(User.first.password).to eq(nil)
  end

end
