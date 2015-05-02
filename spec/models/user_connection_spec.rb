require 'rails_helper'

describe UserConnection, type: :model do
  it "creates a valid user connection" do
    expect(build(:user_connection).valid?).to be(true)
  end

  it "validates the presence of a user" do
    expect(build(:user_connection, user: nil).valid?).to be(false)
  end

  it "validates the presence of a connection" do
    expect(build(:user_connection, connection: nil).valid?).to be(false)
  end

  it "validates the uniqueness of connection_id scoped on user_id" do
    user = build(:user)
    connection = build(:connection)
    user_connection = create(:user_connection, connection: connection, user: user)
    user_connection2 = build(:user_connection, connection: connection, user: user)
    expect(user_connection2.valid?).to be(false)
  end
end
