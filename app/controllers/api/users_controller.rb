class Api::UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    p user_params
    if @user.update(user_params)
      render "show"
    else
      render json: "error"
    end
  end

end
