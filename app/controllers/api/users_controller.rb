class Api::UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = current_user

    if @user.update(user_params)
      render "show"
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

end
