require 'rails_helper'


describe Connection, type: :model do
  it "validates the presence of a sender and a receiver" do
    c1 = Connection.new(sender_id: 1, receiver_id: 2)
    expect(c1.valid?).to be(true)

    c2 = Connection.new(receiver_id: 2)
    expect(c2.valid?).to be(false)

    c3 = Connection.new(sender_id: 1)
    expect(c3.valid?).to be(false)
  end

  it "validates that a message is not sent from a user to herself" do
    c1 = Connection.new(sender_id: 1, receiver_id: 1)
    expect(c1.valid?).to be(false)
  end

  it "validates that the status may only be 'pending' upon creation" do
    c1 = Connection.new(sender_id: 1, receiver_id: 2, status: 1)
    expect(c1.valid?).to be(false)

    c2 = Connection.create!(sender_id: 1, receiver_id: 2)
    c2 = Connection.first
    c2.status = 1
    expect(c2.valid?). to be(true)
  end

end
