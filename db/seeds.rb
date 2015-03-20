User.destroy_all
Experience.destroy_all

NUM_USERS = 100
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
    picture: Faker::Avatar.image(rand(1..1000),"200x200")
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

user1 = User.create!(email: "joe", password: "joejoe",
  fname: "Joe", lname: "Balistreri", tagline: "Studies software development at App Academy",
  location: "New York, NY", industry: "Computer Software",
  date_of_birth: Date.new(1991, 7, 24), summary: "", picture: File.open(Rails.root.join("app", "assets", "images", "cute-robot.jpg")))

user1.experiences.create!(
  experience_type: 0,
  role: "Strategy Consultant",
  institution: "Dean & Company",
  location: "Washington, DC",
  description: "Provided diligence support to private equity firms on $700MM+ in completed transactions.",
  start_date: Date.new(2013, 8, 1),
  end_date: Date.new(2014, 12, 1)
)

user1.experiences.create!(
  experience_type: 1,
  role: "Bachelors of the Arts",
  institution: "Dartmouth College",
  location: "Hanover, NH",
  description: "",
  start_date: Date.new(2009, 1, 1),
  end_date: Date.new(2013, 1, 1)
)

user1.experiences.create!(
  experience_type: 1,
  role: "Rails/Backbone Student",
  institution: "App Academy",
  location: "New York, NY",
  description: "",
  start_date: Date.new(2015, 1, 1),
  end_date: nil
)

# USER CREATION
(NUM_USERS-1).times do |i|
  user = make_user
  add_high_school(user)
  add_college(user)
  add_adv_deg(user) if i % ADV_DEG_FREQ === 0

  loop do
    break unless add_job(user)
  end
end

# CONNECTION CREATION
first_user_id = User.first.id
last_user_id = User.last.id

NUM_USERS.times do |i|
  current_sender_id = first_user_id + i

  first_receiver_id = current_sender_id + 1
  num_connections = rand( (NUM_USERS - i - 1) / CONNECTION_DILUTOR)

  receiver_ids = (first_receiver_id..last_user_id).to_a.sample(num_connections)

  receiver_ids.each do |receiver_id|
    swap = [true,false].sample
    Connection.create!(
      sender_id: swap ? receiver_id : current_sender_id,
      receiver_id: swap ? current_sender_id : receiver_id,
      status: [0,1,1,1,1].sample )
  end

end



demo = User.first

connection_ids = demo.connected_users.map(&:id)

demo.sent_messages.create!(receiver_id: connection_ids.sample,
                        subject: "Coffee this week",
                        body: "Hey NAME! \n\n Are you free to get coffee sometime this week? I heard you got a new job and I'd love to hear about it. It sounds like you've been doing some really interesting work. \n I'm free sometime next Tuesday afternoon if that works for you. There's a great new place in Soho we could check out. \n \n Best, \n -Joe")
demo.sent_messages.create!(receiver_id: connection_ids.sample,
                        subject: "Networking event",
                        body: "NAME, \n\n It was great seeing you at the company networking event last week. How have things been on the new project this week? \n \n -Joe")
demo.sent_messages.create!(receiver_id: connection_ids.sample,
                        subject: "New position opening at Dean",
                        body: "NAME, \n\n I remember you mentioned that you'd be interested in working at Dean, and one of my former colleagues just told me a position opened up on the private equity team. Are you still interested in making the transition to consulting? If so, let me know and I'll recommend you for the job. \n \n Best, \n -Joe")
demo.sent_messages.create!(receiver_id: connection_ids.sample,
                        subject: "Dartmouth meetup",
                        body: "Hi NAME, \n\n Are you gonna go to the Dartmouth cocktails event this weekend? It could be fun if you wanna head over together after work. \n \n -Joe")
demo.sent_messages.create!(receiver_id: connection_ids.sample,
                        subject: "Phone call tomorrow",
                        body: "NAME, \n\n Would it be alright if we rescheduled tomorrow's phone call? Something just came up at work, but I'd still love to chat. Could you do same time next week instead? \n \n Best, \n -Joe")

demo.received_messages.create!(sender_id: connection_ids.sample,
                        subject: "RE: Coffee this week",
                        body: "Joe, yes! \n\n I'd love to get coffee. It sounds like you're up to some cool stuff at App Academy. Let me know when you're free! \n \n --NAME")
demo.received_messages.create!(sender_id: connection_ids.sample,
                        subject: "RE: Coffee this week",
                        body: "Joe, yes! \n\n I'd love to get coffee. It sounds like you're up to some cool stuff at App Academy. Let me know when you're free! \n \n --NAME")
demo.received_messages.create!(sender_id: connection_ids.sample,
                        subject: "RE: Coffee this week",
                        body: "Joe, yes! \n\n I'd love to get coffee. It sounds like you're up to some cool stuff at App Academy. Let me know when you're free! \n \n --NAME")
demo.received_messages.create!(sender_id: connection_ids.sample,
                        subject: "RE: Coffee this week",
                        body: "Joe, yes! \n\n I'd love to get coffee. It sounds like you're up to some cool stuff at App Academy. Let me know when you're free! \n \n --NAME")
demo.received_messages.create!(sender_id: connection_ids.sample,
                        subject: "RE: Coffee this week",
                        body: "Joe, yes! \n\n I'd love to get coffee. It sounds like you're up to some cool stuff at App Academy. Let me know when you're free! \n \n --NAME")
