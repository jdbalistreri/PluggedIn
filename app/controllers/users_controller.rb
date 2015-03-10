class UsersController < ApplicationController

  def create
    @user = User.new(user_params)

    if @user.save
      log_in!(@user)
      redirect_to :root
    else
      render :new
    end
  end

  def new
    @user = User.new
  end

end
