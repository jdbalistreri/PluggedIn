class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def log_in!(user)
    session[:token] = user.reset_session_token!
  end

  def log_out!
    return nil if session[:token].nil?
    current_user.reset_session_token!
    session[:token] = nil
  end

  def current_user
    return nil if session[:token].nil?
    @current_user ||= User.find_by({session_token: session[:token]})
  end

  def logged_in?
    !!current_user
  end



  private
    def require_logged_in
      redirect_to new_session_url unless logged_in?
    end

    def user_params
      params.require(:user).permit(:password, :email, :fname, :lname, :location,
            :tagline, :industry, :date_of_birth, :summary)
    end
end
