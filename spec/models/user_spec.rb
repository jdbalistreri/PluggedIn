require 'rails_helper'

describe User, type: :model do
  it "creates a valid user" do
    expect(build(:user).valid?).to be(true)
  end

  it "ensures a session token upon user creation" do
    expect(build(:user).session_token).not_to be(nil)
  end

  it "validates the presence of a password" do
    expect( build(:user, password: "").valid?).to be(false)
  end

  it "validates the presence of an email" do
    expect(build(:user, email: "").valid?).to be(false)
  end

  it "validates the presence of an fname" do
    expect(build(:user, fname: "").valid?).to be(false)
  end

  it "validates the presence of an lname" do
    expect(build(:user, lname: "").valid?).to be(false)
  end

  it "validates that users have a unique email address" do
    create(:user, email: "user@example.com")
    expect(build(:user, email: "user@example.com").valid?).to be(false)
  end

  it "finds a user by username and password" do
    user = create(:user, email: "user@example.com", password: "password")
    found_user = User.find_by_credentials("user@example.com", "password")
    expect(user.id).to equal(found_user.id)
  end

  it "does not save a user's password" do
    create(:user)
    expect(User.first.password).to eq(nil)
  end
end
