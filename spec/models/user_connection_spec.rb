require 'rails_helper'


describe UserConnection, type: :model do
  it "validates the presence of a user and a connection" do
    c1 = UserConnection.new(user_id: 1, connection_id: 1)
    expect(c1.valid?).to be(true)

    c2 = UserConnection.new(user_id: 1)
    expect(c2.valid?).to be(false)

    c3 = UserConnection.new(connection_id: 1)
    expect(c3.valid?).to be(false)
  end

end
