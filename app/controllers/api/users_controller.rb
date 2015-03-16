class Api::UsersController < ApplicationController

  def index
    @users = User.all.includes(:connections)
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    sleep 0.3

    @user = current_user

    if @user.update(user_params)
      render "show"
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

end
