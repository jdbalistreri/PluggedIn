class Api::UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    if current_user.update(user_params)
      @user = current_user
      render "show"
    else
      render json: "error"
    end
  end

end
