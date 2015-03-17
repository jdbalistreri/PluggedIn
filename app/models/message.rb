class Message < ActiveRecord::Base

  validates :sender_id, :receiver_id, :subject, :body, presence: true;
  validate :different_sender_and_receiver

  belongs_to(
    :sender,
    class_name: "User",
    primary_key: :id,
    foreign_key: :sender_id,
    inverse_of: :sent_messages
  )

  belongs_to(
    :receiver,
    class_name: "User",
    primary_key: :id,
    foreign_key: :receiver_id,
    inverse_of: :received_messages
  )

  private
    def different_sender_and_receiver
      if self.sender_id && self.sender_id == self.receiver_id
        errors[:base] << "You may not message yourself."
      end
    end

end
