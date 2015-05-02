require 'rails_helper'

describe Connection, type: :model do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }

  it "creates a valid connection" do
    expect(build(:connection).valid?).to be(true)
  end

  it "validates the presence of a sender" do
    expect(build(:connection, sender: nil).valid?).to be(false)
  end

  it "validates the presence of a receiver" do
    expect(build(:connection, receiver: nil).valid?).to be(false)
  end

  it "validates that a connection cannot be sent from a user to herself" do
    connection = build(:connection, sender: user1, receiver: user1)
    expect(connection.valid?).to be(false)
  end

  it "ensures a 'pending' status if not specificed" do
    expect(build(:connection).pending?).to be(true)
  end

  it "generates corresponding UserConnection models on create" do
    connection = create(:connection, sender: user1, receiver: user2)
    expect(UserConnection.count).to be(2)
  end

  it "ensures that connections between one user and another cannot be duplicated" do
    connection = create(:connection, sender: user1, receiver: user2)
    connection2 = build(:connection, sender: user2, receiver: user1)
    expect(connection2.valid?).to be(false)
  end
end
