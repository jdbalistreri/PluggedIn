FactoryGirl.define do
  factory :experience do
    user
    role "Default Role"
    institution "Default Institution"
    experience_type { [0,1].sample }
    start_date { Faker::Date.between(10.years.ago, Date.today) }
    end_date { Faker::Date.between(start_date || 10.years.ago, Date.today) }
  end
end
