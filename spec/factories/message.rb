FactoryGirl.define do
  factory :message do
    sender
    receiver
    subject "This is a test subject"
    body "This is a test body"
  end
end
