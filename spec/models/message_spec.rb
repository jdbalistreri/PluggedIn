require 'rails_helper'


describe Message, type: :model do
  it "validates the presence of a subject and title" do
    m = Message.new(subject: "subject", body: "body",
                    sender_id: 1, receiver_id: 2)

    expect(m.valid?).to be(true)

    m2 = Message.new(body: "body",
                    sender_id: 1, receiver_id: 2)

    expect(m2.valid?).to be(false)

    m3 = Message.new(subject: "subject",
                    sender_id: 1, receiver_id: 2)

    expect(m3.valid?).to be(false)
  end


  it "validates the presence of a sender and a receiver"

  it "validates that a user cannot message herself"

end
