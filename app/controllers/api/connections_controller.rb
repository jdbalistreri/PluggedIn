class Api::ConnectionsController < ApplicationController
  before_action :require_logged_in

  def create
    @connection = Connection.new(connection_params)
    @connection.sender_id = current_user.id

    if @connection.save
      @connection = Connection.includes(:receiver).find(@connection.id)
      render :partial => "api/shared/connection.json.jbuilder", :locals => { connection: @connection,
          sent: true, user: @connection.receiver }
    else
      render json: @connection.errors.full_messages,
             status: :unprocessable_entity
    end
  end

  def update
    begin
      @connection = current_user.connections.includes(:users).find(params[:id])

      if @connection.update(status: params[:status])
        render :partial => "api/shared/connection.json.jbuilder", :locals => { connection: @connection,
            sent: true, user: @connection.receiver }
      else
        render json: @connection.errors.full_messages,
               status: :unprocessable_entity
      end
    rescue
      render json: "record not found", status: :unprocessable_entity
    end
  end

  private

    def connection_params
      params.require(:connection).permit(:receiver_id)
    end
end
