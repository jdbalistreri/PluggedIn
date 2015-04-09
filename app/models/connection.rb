class Connection < ActiveRecord::Base
  enum status: [:pending, :approved, :ignored]

  validates :sender_id, :receiver_id, presence: true
  validate :cannot_send_to_self
  validate :cannot_duplicate_connections, on: :create
  after_initialize :ensure_status
  after_create :make_user_connections

  has_many :user_connections, inverse_of: :connection, dependent: :destroy
  has_many :users, through: :user_connections, source: :user

  belongs_to(
    :sender,
    class_name: 'User',
    foreign_key: :sender_id,
    primary_key: :id
  )

  belongs_to(
    :receiver,
    class_name: 'User',
    foreign_key: :receiver_id,
    primary_key: :id
  )

  private

    def ensure_status
      self.status ||= 0
    end

    def cannot_send_to_self
      errors[:base] << 'A user cannot message herself' if sender_id &&
                                                          receiver_id &&
                                                          sender_id == receiver_id
    end

    def cannot_duplicate_connections
      return unless sender_id && receiver_id
      if User.find(sender_id).all_connected_users
             .map(&:id).include?(receiver_id)
        errors[:base] << "Cannot make a duplicate connection"
      end
    end

    def make_user_connections
      UserConnection.create!(connection_id: id, user_id: sender_id)
      UserConnection.create!(connection_id: id, user_id: receiver_id)
    end
end
