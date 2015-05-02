require 'rails_helper'

describe Message, type: :model do
  it "creates a valid message" do
    expect(build(:message).valid?).to be(true)
  end

  it "validates the presence of a subject" do
    expect(build(:message, subject: "").valid?).to be(false)
  end

  it "validates the presence of a body" do
    expect(build(:message, body: "").valid?).to be(false)
  end

  it "validates the presence of a sender" do
    expect(build(:message, sender: nil).valid?).to be(false)
  end

  it "validates the presence of a receiver" do
    expect(build(:message, receiver: nil).valid?).to be(false)
  end

  it "validates that a user cannot message herself" do
    user = create(:user)
    expect(build(:message, sender: user, receiver: user).valid?).to be(false)
  end
end
