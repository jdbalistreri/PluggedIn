FactoryGirl.define do
  factory :user, aliases: [:sender, :receiver] do
    email { Faker::Internet.email }
    password "password"
    fname "John"
    lname "Doe"
  end
end
