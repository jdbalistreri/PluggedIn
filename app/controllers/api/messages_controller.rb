class Api::MessagesController < ApplicationController

  def create

    @message = current_user.sent_messages.new(message_params)

    if @message.save
      render :show
    else
      render json: @message.errors.full_messages, status: :unprocessable_entity
    end
  end

  def sent
    @sent_messages = current_user.sent_messages.includes(:receiver)
  end

  def received
    @received_messages = current_user.received_messages.includes(:sender)
  end

  private
    def message_params
      params.require(:message)
        .permit(:receiver_id, :subject, :body, :reply_to_id)
    end

end
