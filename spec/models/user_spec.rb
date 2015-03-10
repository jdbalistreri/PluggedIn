require 'rails_helper'


describe User, type: :model do

  it "validates the presence of an email and password" do
    user1 = User.new(email: "user@example.com", password: "")
    expect(user1.valid?).to be(false)

    user2 = User.new(email: "", password: "password")
    expect(user2.valid?).to be(false)
  end

  it "validates that users have a unique email address" do
    user1 = User.create!(email: "user@example.com", password: "password")
    user2 = User.new(email: "user@example.com", password: "password")
    expect(user2.valid?).to be(false)
  end

  it "ensures a session token upon user creation" do
    user1 = User.new()
    expect(user1.session_token).not_to be(nil)

  end

  it "finds a user by username and password" do
    user1 = User.create!(email: "user@example.com", password: "password")
    found_user = User.find_by_credentials("user@example.com", "password")
    expect(user1.id).to equal(found_user.id)

    found_user2 = User.find_by_credentials("user@example.com", "other")
    expect(found_user2).to equal(nil)
  end

  it "does not save a user's password" do
    user1 = User.create!(email: "user@example.com", password: "password")
    expect(User.first.password).to eq(nil)
  end

end
