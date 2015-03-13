require 'rails_helper'
require 'byebug'

describe UserConnection, type: :model do

  let(:user1) { User.create!(email: "user1@example.com", password: "password",
                              fname: "joe", lname: "bal")}
  let(:user2) { User.create!(email: "user2@example.com", password: "password",
                              fname: "joe", lname: "bal")}
  let(:connection) { Connection.create!(sender_id: user1.id, receiver_id: user2.id)}

  it "validates the presence of a user and a connection"
    # this was failing because the connection automatically creates
    # user connection instances

  it "validates the uniqueness of connection_id scoped on user_id"

end
