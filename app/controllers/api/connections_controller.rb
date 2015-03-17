class Api::ConnectionsController < ApplicationController

  def create
    @connection = Connection.new(connection_params)
    @connection.sender_id = current_user.id

    if @connection.save
      @connection = Connection.includes(:receiver).find(@connection.id)
      render :show
    else
      render json: @connection.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    @connection = current_user.connections.includes(:users).find(params[:id])

    if @connection.update({status: params[:status]})
      render :show
    else
      render json: @connection.errors.full_messages, status: :unprocessable_entity
    end
  end

  private
    def connection_params
      params.require(:connection).permit(:receiver_id)
    end

end
