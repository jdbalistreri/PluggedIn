class UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save
      log_in!(@user)
      redirect_to :root
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def new
    @user = User.new
  end

  def new_demo
    @user = User.new_demo
    @user.save!
    render json: { email: @user.email, password: @user.password }
  end
end
