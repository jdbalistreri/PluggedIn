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
    @message = current_user.sent_messages.find(params[:id]) ||
      current_user.received_messages.find(params[:id])
  end

  private
    def message_params
      params.require(:message)
        .permit(:receiver_id, :subject, :body, :reply_to_id)
    end

end
