class Api::ConnectedUsersController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @connections = @user.connections.includes(:users)
  end

end
