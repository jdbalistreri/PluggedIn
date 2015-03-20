class Api::MessagesController < ApplicationController

  def create

    @message = current_user.sent_messages.new(message_params)

    if @message.save
      @message = Message.includes(:receiver).find(@message.id)
      @sent = true
      @user = @message.receiver
      render :show
    else
      render json: @message.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    found = false
    messages = current_user.sent_messages.to_a.concat(current_user.received_messages.to_a)
    messages.each do |message|
      found = true if message.id == Integer(params[:id])
    end

    if found
      @message = Message.find(params[:id])

      @sent = @message.sender_id == current_user.id
      if @sent
        @user = @message.receiver
      else
        @user = @message.sender
      end
    else
      render json: "no message found"
    end
  end

  private
    def message_params
      params.require(:message)
        .permit(:receiver_id, :subject, :body, :reply_to_id)
    end

end
