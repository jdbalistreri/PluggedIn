require 'byebug'

class Api::ConnectionsController < ApplicationController

  def create

  end

  def index
    user = User.find(params[:user_id])
    @connected_users = user.connected_users
  end

  def update

  end

end
