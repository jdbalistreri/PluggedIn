class Api::MessagesController < ApplicationController

  def create

    @message = current_user.sent_messages.new(message_params)

    if @message.save
      @message = Message.includes(:receiver).find(@message.id)
      render :show
    else
      render json: @message.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    found = false
    messages = current_user.sent_messages.to_a.concat(current_user.received_messages.to_a)
    messages.each do |message|
      found = true if message.sender_id == current_user.id || message.receiver_id == current_user.id
    end

    @message = Message.find(params[:id]) if found
  end

  private
    def message_params
      params.require(:message)
        .permit(:receiver_id, :subject, :body, :reply_to_id)
    end

end
