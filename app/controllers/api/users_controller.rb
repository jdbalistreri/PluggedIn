class Api::UsersController < ApplicationController
  before_action :require_logged_in
  
  def index
    users = User.all.includes(:connections)
    @users = []
    users.each do |user|
      cu_connection = user.connection_with(current_user)
      @users << user if cu_connection && cu_connection.approved?
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = current_user

    if @user.update(user_params)
      render 'show'
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end
end
