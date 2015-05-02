require 'rails_helper'

describe Message, type: :model do
  it "creates a valid message" do
    message = build(:message)
    expect(message.valid?).to be(true)
  end

  it "validates the presence of a subject" do
    message = build(:message, subject: "")
    expect(message.valid?).to be(false)
  end

  it "validates the presence of a body" do
    message = build(:message, body: "")
    expect(message.valid?).to be(false)
  end

  it "validates the presence of a sender" do
    message = build(:message, sender: nil)
    expect(message.valid?).to be(false)
  end

  it "validates the presence of a receiver" do
    message = build(:message, receiver: nil)
    expect(message.valid?).to be(false)
  end

  it "validates that a user cannot message herself" do
    user = create(:user)
    message = build(:message, sender: user, receiver: user)
    expect(message.valid?).to be(false)
  end
end
