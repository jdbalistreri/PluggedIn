class Api::UsersController < ApplicationController
  before_action :require_logged_in

  def show
    @user = User.find(params[:id])
    render 'api/users/show.json.jbuilder'
  end

  def update
    @user = current_user

    if @user.update(user_params)
      render 'api/users/show.json.jbuilder'
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end
end
