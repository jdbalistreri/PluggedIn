class Api::ConnectionsController < ApplicationController

  def create
    @connection = Connection.new(connection_params)
    @connection.sender_id = current_user.id

    if @connection.save
      render json: @connection
    else
      render json: @connection.errors.full_messages, status: :unprocessable_entity
    end
  end

  def index
    @connections = current_user.connections
  end

  def update
    @connection = current_user.connections.find(params[:id])

    if @connection.update({status: params[:status]})
      render json: @connection
    else
      render json: @connection.errors.full_messages, status: :unprocessable_entity
    end
  end

  private
    def connection_params
      params.require(:connection).permit(:receiver_id)
    end

end
