require 'rails_helper'


describe Message, type: :model do
  let(:user1) { User.create!(email: "user1@example.com", password: "password",
                              fname: "joe", lname: "bal")}
  let(:user2) { User.create!(email: "user2@example.com", password: "password",
                              fname: "joe", lname: "bal")}

  it "validates the presence of a subject and title" do
    m = user1.sent_messages.new(subject: "subject", body: "body",
                    receiver_id: user2.id)
    expect(m.valid?).to be(true)

    m2 = user1.sent_messages.new(body: "body", receiver_id: user2.id)
    expect(m2.valid?).to be(false)

    m3 = user1.sent_messages.new(subject: "subject", receiver_id: user2.id)
    expect(m3.valid?).to be(false)
  end

  it "validates the presence of a sender and a receiver" do
    m = user1.sent_messages.new(subject: 's', body: 'b', receiver_id: user2.id)
    expect(m.valid?).to be(true)

    m2 = user1.sent_messages.new(subject: 's', body: 'b')
    expect(m2.valid?).to be(false)

    m3 = Message.new(subject: 's', body: 'b', sender_id: user1.id)
    expect(m2.valid?).to be(false)

  end

  it "validates that a user cannot message herself" do
    m = user1.sent_messages.new(subject: 's', body: 'b', receiver_id: user1.id)
    expect(m.valid?).to be(false)
  end

end
