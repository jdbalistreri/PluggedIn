module UserSeeds
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
  MAX_USER_AGE = 60
  MIN_USER_AGE = 18
  ADV_DEG_FREQ = 2
  CONNECTION_DILUTOR = 2

  def self.included(base)
    base.send :extend, ClassMethods
  end

  module ClassMethods
    def new_demo
      user = self.make_user("demouser#{SecureRandom::random_number(1000)}@demo.com")
      user.provider = "Demo"
      user.add_connections
      user.add_messages
      user
    end

    def make_user(email = nil)
      fname = Faker::Name.first_name
      lname = Faker::Name.last_name
      summary = "#{Faker::Company.bs.capitalize}."


      user = User.create!(
        email: email || Faker::Internet.free_email("#{fname}.#{lname}"),
        password: "password",
        fname: fname,
        lname: lname,
        tagline: Faker::Name.title,
        location: User.rand_location,
        industry: Faker::Commerce.department(2),
        date_of_birth: Faker::Date.between(MAX_USER_AGE.years.ago, MIN_USER_AGE.years.ago),
        summary: summary,
        picture: Faker::Avatar.image(rand(1..1000),"200x200")
      )

      user.add_experiences

      user
    end

    def rand_location
      "#{Faker::Address.city}, #{Faker::Address.state}"
    end

  end

  def add_messages
    connected_users = self.connected_users


    target_user = connected_users.sample
    self.sent_messages.create!(receiver_id: target_user.id,
                            subject: "Coffee this week",
                            body: "Hey #{target_user.fname}! \n\n Are you free to get coffee sometime this week? I heard you got a new job and I'd love to hear about it. It sounds like you've been doing some really interesting work. \n I'm free sometime next Tuesday afternoon if that works for you. There's a great new place in Soho we could check out. \n \n Best, \n -#{self.fname}")
    target_user = connected_users.sample
    self.sent_messages.create!(receiver_id: target_user.id,
                            subject: "Networking event",
                            body: "#{target_user.fname}, \n\n It was great seeing you at the company networking event last week. How have things been on the new project this week? \n \n -#{self.fname}")
    target_user = connected_users.sample
    self.sent_messages.create!(receiver_id: target_user.id,
                            subject: "New position opening at Dean",
                            body: "#{target_user.fname}, \n\n I remember you mentioned that you'd be interested in working at Dean, and one of my former colleagues just told me a position opened up on the private equity team. Are you still interested in making the transition to consulting? If so, let me know and I'll recommend you for the job. \n \n Best, \n -#{self.fname}")
    target_user = connected_users.sample
    self.sent_messages.create!(receiver_id: target_user.id,
                            subject: "Dartmouth meetup",
                            body: "Hi #{target_user.fname}, \n\n Are you gonna go to the Dartmouth cocktails event this weekend? It could be fun if you wanna head over together after work. \n \n -#{self.fname}")
    target_user = connected_users.sample
    self.sent_messages.create!(receiver_id: target_user.id,
                            subject: "Phone call tomorrow",
                            body: "#{target_user.fname}, \n\n Would it be alright if we rescheduled tomorrow's phone call? Something just came up at work, but I'd still love to chat. Could you do same time next week instead? \n \n Best, \n -#{self.fname}")

    target_user = connected_users.sample
    self.received_messages.create!(sender_id: target_user.id,
                            subject: "RE: Networking event",
                            body: "#{self.fname}, \n\n Yes. The networking event will be held at 7 pm this coming Tuesday. Please arrive at our offices a few minutes early to get your nametag. \n \n --#{target_user.fname}")
    target_user = connected_users.sample
    self.received_messages.create!(sender_id: target_user.id,
                            subject: "RE: Coffee this week",
                            body: "#{self.fname}, yes! \n\n I'd love to get coffee. It sounds like you're up to some cool stuff at App Academy. Let me know when you're free! \n \n --#{target_user.fname}")
    target_user = connected_users.sample
    self.received_messages.create!(sender_id: target_user.id,
                            subject: "RE: Summer Hiking Trip",
                            body: "#{self.fname}, \n\n We should definitely get the rest of our friends together and road trip across the country. I'd love to go climbing at Joshua Tree, and I know you've been climbing a lot lately. It'll be fun! \n \n --#{target_user.fname}")
    target_user = connected_users.sample
    self.received_messages.create!(sender_id: target_user.id,
                            subject: "RE: Your Recommendation",
                            body: "#{self.fname}, \n\n Thank you for recommending Tanya for the position at Acme Corp. We're in the process of reviewing her application, and we're very excited about the prospect of working with her. \n \n Warm regards, \n #{target_user.full_name}")
    target_user = connected_users.sample
    self.received_messages.create!(sender_id: target_user.id,
                            subject: "RE: RE: Start Up Idea",
                            body: "#{self.fname}, \n\n It sounds like you'd be a great fit for our team. We're looking to get moving quickly, so let me know soon if you'd like to join the team. I'll send you the full details via email later tonight. \n \n Best, \n #{target_user.fname}")
  end

  def add_connections
    all_ids = User.all.pluck(:id)
    num_connections = rand( all_ids.length / CONNECTION_DILUTOR)

    receiver_ids = all_ids.sample(num_connections)

    receiver_ids.each do |receiver_id|
      next if receiver_id == self.id
      swap = [true,false].sample
      Connection.create(
        sender_id: swap ? receiver_id : self.id,
        receiver_id: swap ? self.id : receiver_id,
        status: [0,1,1,1,1].sample )
    end
    nil
  end

  def add_experiences
    self.add_high_school
    self.add_college
    self.add_adv_deg if self.id % ADV_DEG_FREQ === 0

    loop do
      break unless self.add_job
    end
  end
  def add_high_school
    start_date = Date.new((Time.now.year - self.age) + 13, 1, 1)
    end_date = Date.new((Time.now.year - self.age) + 17, 1, 1)
    self.last_date = end_date

    self.experiences.create!(
      experience_type: 1,
      role: "High School",
      institution: "#{Faker::Name.last_name} #{["High School", "High", "Prep", "Academy"].sample}",
      location: User.rand_location,
      start_date: start_date,
      end_date: end_date,
      description: nil
    )
  end

  def add_college
    start_date = Date.new((Time.now.year - self.age) + 17, 1, 1)
    end_date = Date.new((Time.now.year - self.age) + 21, 1, 1)
    self.last_date = end_date

    self.experiences.create!(
      experience_type: 1,
      role: "Bachelor's Degree",
      institution: "#{Faker::Name.last_name} #{["University", "College", "State"].sample}",
      location: User.rand_location,
      description: nil,
      start_date: start_date,
      end_date: end_date,
      field: MAJORS.sample
    )
  end

  def add_adv_deg
    return nil if self.last_date.nil?

    degree = ADV_DEGREES.sample

    start_date = Date.new(self.last_date.year, 1, 1)
    end_date = Date.new(start_date.year + degree[:years], 1, 1)
    self.last_date = end_date

    self.experiences.create!(
      experience_type: 1,
      role: degree[:degree],
      institution: "#{Faker::Name.last_name} #{["University", "College"].sample}",
      location: User.rand_location,
      description: nil,
      start_date: start_date,
      end_date: end_date,
      field: (degree[:field] ? MAJORS.sample : nil)
    )
  end

  def add_job
    return false if self.last_date.nil?

    start_year = self.last_date.year + [0,0,0,1].sample
    start_month = self.last_date.month + (1..12).to_a.sample

    if start_month > 12
      start_month -= 12
      start_year += 1
    end

    end_year = start_year + (1..15).to_a.sample
    end_month = (1..12).to_a.sample

    start_date = Date.new(start_year, start_month, 1)
    end_date = Date.new(end_year, end_month, 1)

    return false if start_date > Time.now
    self.last_date = end_date

    self.experiences.create!(
      experience_type: 0,
      role: Faker::Name.title,
      institution: Faker::Company.name,
      location: User.rand_location,
      description: Faker::Company.catch_phrase,
      start_date: start_date,
      end_date: end_date > Time.now ? nil : end_date
    )
    true
  end

end
