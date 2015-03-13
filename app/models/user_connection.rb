class UserConnection < ActiveRecord::Base

  validates :user, :connection, presence: true

  belongs_to :user, inverse_of: :user_connections
  belongs_to :connection, inverse_of: :user_connections

end
