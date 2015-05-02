require 'rails_helper'

describe Connection, type: :model do
  let(:user1) { User.create!(email: "user1@example.com", password: "password",
                              fname: "joe", lname: "bal")}
  let(:user2) { User.create!(email: "user2@example.com", password: "password",
                              fname: "joe", lname: "bal")}

  it "validates the presence of a sender and a receiver" do
    c1 = Connection.new(sender_id: user1.id, receiver_id: user2.id)
    expect(c1.valid?).to be(true)

    c2 = Connection.new(receiver_id: user1.id)
    expect(c2.valid?).to be(false)

    c3 = Connection.new(sender_id: user1.id)
    expect(c3.valid?).to be(false)
  end

  it "validates that a message is not sent from a user to herself" do
    c1 = Connection.new(sender_id: user1.id, receiver_id: user1.id)
    expect(c1.valid?).to be(false)
  end

  it "ensures a pending status on create"
  it "does not validate that the status may only be 'pending' upon creation" do
    c1 = Connection.new(sender_id: user1.id, receiver_id: user2.id, status: 1)
    expect(c1.valid?).to be(true  )

    c2 = Connection.create!(sender_id: user1.id, receiver_id: user2.id)
    c2 = Connection.first
    c2.status = 1
    expect(c2.valid?). to be(true)
  end

  it "automatically creates UserConnections on create"
  it "ensures that connections between one user and another cannot be duplicated"

end
