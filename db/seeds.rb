User.destroy_all
Experience.destroy_all

BASIC_DEGREES = ["High School", "Bachelor's Degree"]
ADV_DEGREES   = ["Master's Degree", "Master's of Business Administration,
                  Doctor of Medicine (M.D.), Doctor of Philosophy (Ph.D.)"]
MAJORS = ["Anthropology", "Art History", "Biological Sciences", "Chemistry", "Classics", "Comparative Literature", "Computer Science", "Earth Sciences", "Economics", "Education", "Engineering Sciences", "English", "Environmental Studies", "Film and Media Studies", "Geography", "Government", "History", "LGBT Studies", "Linguistics", "Mathematics", "Music", "Native American Studies", "Neuroscience", "Philosophy", "Physics and Astronomy", "Psychology", "Religion", "Russian Literature", "Sociology", "Spanish Literature", "Studio Art", "Theater", "Women’s and Gender"]

user1 = User.create!(email: "joe", password: "joejoe",
  fname: "Joe", lname: "Bali", tagline: "ain't life grand?",
  location: "Milwaukee, WI", industry: "Computer Software",
  date_of_birth: Date.new(1991, 7, 24), summary: "This is my summary")

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
    date_of_birth: Faker::Date.between(60.years.ago, 18.years.ago),
    summary: summary,
    picture: Faker::Avatar.image
  )

  user
end

def add_high_school(user)
  start_date = Date.new((Time.now.year - user.age) + 13, 1, 1)
  end_date = Date.new((Time.now.year - user.age) + 17, 1, 1)
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

def add_job(user)
end


15.times do
  user = make_user
  add_high_school(user)
  add_college(user)
end
