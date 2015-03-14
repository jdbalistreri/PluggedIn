User.destroy_all
Experience.destroy_all

NUM_USERS = 10
CONNECTION_DILUTOR = 2
ADV_DEG_FREQ = 2
MAX_USER_AGE = 60
MIN_USER_AGE = 18


ADV_DEGREES   = [{degree: "Master's Degree",
                    years: 2,
                    field: true},
                  {degree: "Master's of Business Administration",
                    years: 2,
                    field: false},
                  {degree: "Doctor of Medicine (M.D.)",
                    years: 4,
                    field: false},
                  {degree: "Doctor of Philosophy (Ph.D.)",
                    years: 5,
                    field: true}]

MAJORS = ["Anthropology", "Art History", "Biological Sciences", "Chemistry", "Classics", "Comparative Literature", "Computer Science", "Earth Sciences", "Economics", "Education", "Engineering Sciences", "English", "Environmental Studies", "Film and Media Studies", "Geography", "Government", "History", "LGBT Studies", "Linguistics", "Mathematics", "Music", "Native American Studies", "Neuroscience", "Philosophy", "Physics and Astronomy", "Psychology", "Religion", "Russian Literature", "Sociology", "Spanish Literature", "Studio Art", "Theater", "Women’s and Gender"]

def rand_location
  "#{Faker::Address.city}, #{Faker::Address.state}"
end

def make_user
  fname = Faker::Name.first_name
  lname = Faker::Name.last_name
  summary = "#{Faker::Company.bs.capitalize}."


  user = User.create(
    email: Faker::Internet.free_email("#{fname}.#{lname}"),
    password: "password",
    fname: fname,
    lname: lname,
    tagline: Faker::Name.title,
    location: rand_location,
    industry: Faker::Commerce.department(2),
    date_of_birth: Faker::Date.between(MAX_USER_AGE.years.ago, MIN_USER_AGE.years.ago),
    summary: summary,
    picture: Faker::Avatar.image("robot","200x200")
  )

  user
end

def add_high_school(user)
  start_date = Date.new((Time.now.year - user.age) + 13, 1, 1)
  end_date = Date.new((Time.now.year - user.age) + 17, 1, 1)
  user.last_date = end_date

  user.experiences.create!(
    experience_type: 1,
    role: "High School",
    institution: "#{Faker::Name.last_name} #{["High School", "High", "Prep", "Academy"].sample}",
    location: rand_location,
    start_date: start_date,
    end_date: end_date,
    description: nil
  )
end

def add_college(user)
  start_date = Date.new((Time.now.year - user.age) + 17, 1, 1)
  end_date = Date.new((Time.now.year - user.age) + 21, 1, 1)
  user.last_date = end_date

  user.experiences.create!(
    experience_type: 1,
    role: "Bachelor's Degree",
    institution: "#{Faker::Name.last_name} #{["University", "College", "State"].sample}",
    location: rand_location,
    description: nil,
    start_date: start_date,
    end_date: end_date,
    field: MAJORS.sample
  )
end

def add_adv_deg(user)
  return nil if user.last_date.nil?

  degree = ADV_DEGREES.sample

  start_date = Date.new(user.last_date.year, 1, 1)
  end_date = Date.new(start_date.year + degree[:years], 1, 1)
  user.last_date = end_date

  user.experiences.create!(
    experience_type: 1,
    role: degree[:degree],
    institution: "#{Faker::Name.last_name} #{["University", "College"].sample}",
    location: rand_location,
    description: nil,
    start_date: start_date,
    end_date: end_date,
    field: (degree[:field] ? MAJORS.sample : nil)
  )
end

def add_job(user)
  return false if user.last_date.nil?

  start_year = user.last_date.year + [0,0,0,1].sample
  start_month = user.last_date.month + (1..12).to_a.sample

  if start_month > 12
    start_month -= 12
    start_year += 1
  end

  end_year = start_year + (1..15).to_a.sample
  end_month = (1..12).to_a.sample

  start_date = Date.new(start_year, start_month, 1)
  end_date = Date.new(end_year, end_month, 1)

  return false if start_date > Time.now
  user.last_date = end_date

  user.experiences.create!(
    experience_type: 0,
    role: Faker::Name.title,
    institution: Faker::Company.name,
    location: rand_location,
    description: Faker::Company.catch_phrase,
    start_date: start_date,
    end_date: end_date > Time.now ? nil : end_date,
  )
  true
end

# USER CREATION
NUM_USERS.times do |i|
  user = make_user
  add_high_school(user)
  add_college(user)
  add_adv_deg(user) if i % ADV_DEG_FREQ === 0

  loop do
    break unless add_job(user)
  end
end

# CONNECTION CREATION
NUM_USERS.times do |sender_idx|
  sample_size = rand( (NUM_USERS - sender_idx - 1) / CONNECTION_DILUTOR)
  connections = (sender_idx+2..NUM_USERS).to_a.sample(sample_size)

  connections.each do |receiver_idx|
    Connection.create!(sender_id: sender_idx + 1, receiver_id: receiver_idx)
  end

end















user1 = User.create!(email: "joe", password: "joejoe",
  fname: "Joe", lname: "Bali", tagline: "ain't life grand?",
  location: "Milwaukee, WI", industry: "Computer Software",
  date_of_birth: Date.new(1991, 7, 24), summary: "This is my summary")
