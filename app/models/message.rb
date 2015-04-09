class Message < ActiveRecord::Base
  validates :sender, :receiver, :subject, :body, presence: true;
  validate :different_sender_and_receiver

  belongs_to(
    :sender,
    class_name: 'User',
    primary_key: :id,
    foreign_key: :sender_id,
    inverse_of: :sent_messages
  )

  belongs_to(
    :receiver,
    class_name: 'User',
    primary_key: :id,
    foreign_key: :receiver_id,
    inverse_of: :received_messages
  )

  belongs_to(
    :previous_message,
    class_name: 'Message',
    primary_key: :id,
    foreign_key: :reply_to_id,
    inverse_of: :replies
  )

  has_many(
    :replies,
    class_name: 'Message',
    primary_key: :id,
    foreign_key: :reply_to_id,
    inverse_of: :previous_message
  )

  def date_string
    created_at.to_formatted_s(:long_ordinal)
  end

  def body_preview
    if body.length > 65
      output = ''

      body.split(' ').each do |word|
        if output.length + word.length < 62
          output += "#{word} "
        else
          output.strip!
          output += '...'
          return output
        end
      end

      output
    else
      body
    end
  end

  private

    def different_sender_and_receiver
      if sender_id && sender_id == receiver_id
        errors[:base] << 'You may not message yourself.'
      end
    end
end
