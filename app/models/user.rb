class User < ActiveRecord::Base
  include PgSearch
  multisearchable against: [:fname, :lname]

  validates :password_digest, :email, :session_token, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}
  validates :email, :session_token, uniqueness: true
  validate :name_presence
  after_initialize :ensure_session_token

  has_many(
    :experiences,
    dependent: :destroy,
    inverse_of: :user
  )

  has_many :user_connections, inverse_of: :user, dependent: :destroy
  has_many(
    :connections,
    through: :user_connections,
    source: :connection,
    dependent: :destroy
  )

  has_attached_file :picture, styles: {profile: "200x200>", thumb: "60x60>"}, default_url: "default.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/

  def num_connections
    count = 0
    self.connections.each do |connection|
      count += 1 if connection.approved?
    end
    count
  end

  # def num_shared_connections_with(user)
  #   # count = 0
  #   # self.connections.each do |connection|
  #   #   count += 1 if connection.sender_id == user.id || connection.receiver_id == user.id
  #   # end
  #   # count
  #   self.shared_users_with(user).length
  # end

  def connection_with(user)
    self.connections.each do |connection|
      return connection if connection.sender_id == user.id || connection.receiver_id == user.id
    end
    nil
  end

  # def shared_users_with(other_user)
  #   join1 = "JOIN user_connections uc3 ON u2.id = uc3.user_id"
  #   join2 = "JOIN user_connections uc4 ON uc3.connection_id = uc4.connection_id"
  #   join3 = "JOIN users u3 ON uc4.user_id = u3.id"
  #   where = "u3.id = :other_user_id"
  #   self.connected_users
  #       .joins(join1)
  #       .joins(join2)
  #       .joins(join3)
  #       .where([where, {other_user_id: other_user.id}])
  # end

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

  def jobs
    self.experiences.where(experience_type: 0)
  end

  def schools
    self.experiences.where(experience_type: 1)
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

end
