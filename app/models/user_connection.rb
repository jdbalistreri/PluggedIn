class UserConnection < ActiveRecord::Base

  validates :user, :connection, presence: true
  validates_uniqueness_of :user_id, scope: :connection_id

  belongs_to :user, inverse_of: :user_connections
  belongs_to :connection, inverse_of: :user_connections

end
