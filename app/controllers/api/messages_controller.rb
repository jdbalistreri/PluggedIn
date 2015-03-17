class Api::MessagesController < ApplicationController

  def create
    # @connection = Connection.new(connection_params)
    # @connection.sender_id = current_user.id
    #
    # if @connection.save
    #   render :show
    # else
    #   render json: @connection.errors.full_messages, status: :unprocessable_entity
    # end
  end

  def index
    @sent_messages = current_user.sent_messages.includes(:receiver)
    @received_messages = current_user.received_messages.includes(:sender)
  end

  private
    def message_params
      params.require(:connection).permit(:receiver_id)
    end

end
