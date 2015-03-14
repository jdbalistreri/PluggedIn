class Api::ConnectedUsersController < ApplicationController

  def index
    user = User.find(params[:user_id])
    @connected_users = user.connected_users
  end

end
