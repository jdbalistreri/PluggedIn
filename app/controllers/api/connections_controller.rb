class Api::ConnectionsController < ApplicationController

  def create
    @connection = Connection.new(connection_params)
    @connection.sender_id = current_user.id

    if @connection.save
      render :show
    else
      render json: @connection.errors.full_messages, status: :unprocessable_entity
    end
  end

  def index
    @user = User.find(params[:user_id])
    @connections = @user.connections.includes(users: :connections)
  end

  def received
    @received_connections = current_user.received_connections.where(status: 0).includes(:sender)
  end

  def sent
    @sent_connections = current_user.sent_connections.includes(:receiver)
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
