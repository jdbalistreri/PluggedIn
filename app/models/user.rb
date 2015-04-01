class User < ActiveRecord::Base
  include PgSearch
  pg_search_scope(
    :user_search,
    against: [:fname, :lname],
    associated_against: { experiences: [:role, :institution]},
    using: {tsearch: {prefix: true}}
  )

  validates :password_digest, :email, :session_token, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}
  validates :email, :session_token, uniqueness: true
  validate :name_presence
  after_initialize :ensure_session_token
  after_initialize :ensure_defaults

  has_many(
    :sent_messages,
    class_name: "Message",
    primary_key: :id,
    foreign_key: :sender_id,
    inverse_of: :sender
  )

  has_many(
    :received_messages,
    class_name: "Message",
    primary_key: :id,
    foreign_key: :receiver_id,
    inverse_of: :receiver
  )

  has_many(
    :experiences,
    dependent: :destroy,
    inverse_of: :user
  )

  has_many(
    :sent_connections,
    class_name: "Connection",
    foreign_key: :sender_id,
    primary_key: :id
  )

  has_many(
    :received_connections,
    class_name: "Connection",
    foreign_key: :receiver_id,
    primary_key: :id
  )

  has_many :user_connections, inverse_of: :user, dependent: :destroy

  has_many(
    :connections,
    through: :user_connections,
    source: :connection,
    dependent: :destroy
  )

  has_attached_file :picture, styles: {profile: "200x200#", thumb: "60x60#"}, default_url: "default.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/

  def num_connections
    count = 0
    self.connections.each do |connection|
      count += 1 if connection.approved?
    end
    count
  end

  def connection_with(user)
    self.connections.each do |connection|
      return connection if connection.sender_id == user.id || connection.receiver_id == user.id
    end
    nil
  end

  def requested_users
    @requested_users ||= self.all_connected_users
                          .where("c.sender_id = ?", self.id)
                          .where("c.status != 1")
  end

  def connected_users
    @connected_users ||= self.all_connected_users.where("c.status = 1")
  end

  def all_connected_users
    join1 = "JOIN user_connections uc1 ON u1.id = uc1.user_id"
    join2 = "JOIN user_connections uc2 ON uc1.connection_id = uc2.connection_id"
    join3 = "JOIN users u2 ON uc2.user_id = u2.id"
    join4 = "JOIN connections c ON c.id = uc1.connection_id"
    where = "u1.id = :id AND u2.id != :id"
    User.select("u2.*")
        .distinct
        .from("users u1")
        .joins(join1)
        .joins(join2)
        .joins(join3)
        .joins(join4)
        .where([where, {id: self.id}])
  end

  def current_jobs
    @jobs = self.jobs
    @current_jobs.empty? ? nil : @current_jobs
  end

  def previous_jobs
    @jobs = self.jobs
    @previous_jobs.empty? ? nil : @previous_jobs
  end

  def education
    @schools = self.schools
    @education
  end

  def jobs
    return @jobs if @jobs
    jobs = self.experiences.where(experience_type: 0)
    @current_jobs = []
    @previous_jobs = []

    jobs.each do |job|
      if job.end_date.nil?
        @current_jobs << job
      else
        @previous_jobs << job
      end
    end

    @previous_jobs.sort! { |job| job.end_date }

    @current_jobs = @current_jobs.sample(3).map(&:institution).join(", ")
    @previous_jobs = @previous_jobs.sample(3).map(&:institution).join(", ")

    jobs
  end

  def schools
    return @schools if @schools
    schools = self.experiences.where(experience_type: 1)

    @education = schools.map(&:institution).join(", ")

    schools
  end

  def full_name
    "#{fname} #{lname}"
  end

  def age
    DateTime.now.year - self.date_of_birth.year
  end

  def last_date
    return @last_date if @last_date
    end_dates = self.experiences.map(&:end_date)

    if end_dates.any? { |date| date.nil? || Time.now < date }
      @last_date = nil
      return @last_date
    end

    @last_date = end_dates.max
  end

  def last_date=(value)
    @last_date = value > Time.now ? nil : value
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password);
  end

  def password
    @password
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(email, password)
    user = User.find_by({email: email})
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  def self.find_or_create_from_auth_hash(auth_hash)
    user = User.find_by(
            provider: auth_hash[:provider],
            uid: auth_hash[:uid])

    unless user
      user = User.create!(
            provider: auth_hash[:provider],
            uid: auth_hash[:uid],
            fname: auth_hash[:info][:name].split.first,
            lname: auth_hash[:info][:name].split.last,
            email: auth_hash[:info][:nickname],
            password: SecureRandom::urlsafe_base64
      )
    end

    user
  end

  # DEMO USER LOGIC

  def self.new_demo
    user = self.make_user("demouser#{SecureRandom::random_number(1000)}@demo.com")
    user.provider = "Demo"
    user.add_connections
    user.add_messages
    user
  end

  def add_messages
    connection_ids = self.connected_users.map(&:id)

    self.sent_messages.create!(receiver_id: connection_ids.sample,
                            subject: "Coffee this week",
                            body: "Hey NAME! \n\n Are you free to get coffee sometime this week? I heard you got a new job and I'd love to hear about it. It sounds like you've been doing some really interesting work. \n I'm free sometime next Tuesday afternoon if that works for you. There's a great new place in Soho we could check out. \n \n Best, \n -Joe")
    self.sent_messages.create!(receiver_id: connection_ids.sample,
                            subject: "Networking event",
                            body: "NAME, \n\n It was great seeing you at the company networking event last week. How have things been on the new project this week? \n \n -Joe")
    self.sent_messages.create!(receiver_id: connection_ids.sample,
                            subject: "New position opening at Dean",
                            body: "NAME, \n\n I remember you mentioned that you'd be interested in working at Dean, and one of my former colleagues just told me a position opened up on the private equity team. Are you still interested in making the transition to consulting? If so, let me know and I'll recommend you for the job. \n \n Best, \n -Joe")
    self.sent_messages.create!(receiver_id: connection_ids.sample,
                            subject: "Dartmouth meetup",
                            body: "Hi NAME, \n\n Are you gonna go to the Dartmouth cocktails event this weekend? It could be fun if you wanna head over together after work. \n \n -Joe")
    self.sent_messages.create!(receiver_id: connection_ids.sample,
                            subject: "Phone call tomorrow",
                            body: "NAME, \n\n Would it be alright if we rescheduled tomorrow's phone call? Something just came up at work, but I'd still love to chat. Could you do same time next week instead? \n \n Best, \n -Joe")

    self.received_messages.create!(sender_id: connection_ids.sample,
                            subject: "RE: Coffee this week",
                            body: "Joe, yes! \n\n I'd love to get coffee. It sounds like you're up to some cool stuff at App Academy. Let me know when you're free! \n \n --NAME")
    self.received_messages.create!(sender_id: connection_ids.sample,
                            subject: "RE: Coffee this week",
                            body: "Joe, yes! \n\n I'd love to get coffee. It sounds like you're up to some cool stuff at App Academy. Let me know when you're free! \n \n --NAME")
    self.received_messages.create!(sender_id: connection_ids.sample,
                            subject: "RE: Coffee this week",
                            body: "Joe, yes! \n\n I'd love to get coffee. It sounds like you're up to some cool stuff at App Academy. Let me know when you're free! \n \n --NAME")
    self.received_messages.create!(sender_id: connection_ids.sample,
                            subject: "RE: Coffee this week",
                            body: "Joe, yes! \n\n I'd love to get coffee. It sounds like you're up to some cool stuff at App Academy. Let me know when you're free! \n \n --NAME")
    self.received_messages.create!(sender_id: connection_ids.sample,
                            subject: "RE: Coffee this week",
                            body: "Joe, yes! \n\n I'd love to get coffee. It sounds like you're up to some cool stuff at App Academy. Let me know when you're free! \n \n --NAME")
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

  def self.make_user(email = nil)
    fname = Faker::Name.first_name
    lname = Faker::Name.last_name
    summary = "#{Faker::Company.bs.capitalize}."


    user = User.create(
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

  def add_experiences
    self.add_high_school
    self.add_college
    self.add_adv_deg if self.id % ADV_DEG_FREQ === 0

    loop do
      break unless self.add_job
    end
  end

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

  def self.rand_location
    "#{Faker::Address.city}, #{Faker::Address.state}"
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
      end_date: end_date > Time.now ? nil : end_date,
    )
    true
  end

  private
    def ensure_session_token
      self.session_token ||= self.class.generate_session_token
    end

    def name_presence
      unless self.fname.present?
        errors[:base] << "Please include a first name"
      end
      unless self.lname.present?
        errors[:base] << "Please include a last name"
      end
    end

    def ensure_defaults
      self.tagline ||= "Tagline"
      self.industry ||= "Industry"
      self.location ||= "Location"
    end

end
