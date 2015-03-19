class SessionsController < ApplicationController

  def create
    user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password],
    )

    if user
      log_in!(user)
      redirect_to root_url
    else
      flash.now[:errors] = ["Invalid username/password"]
      render :new
    end
  end

  def destroy
    log_out!
    redirect_to new_session_url
  end

  def new
  end

  def omniauth
    @user = User.find_or_create_from_auth_hash()
  end

  private
    def auth_hash
      request.env['omniauth.auth']
    end

end
