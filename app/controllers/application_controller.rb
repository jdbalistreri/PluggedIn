require 'byebug'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :current_user_id, :logged_in?

  def log_in!(user)
    session[:token] = user.reset_session_token!
    session[:refreshes] = 0
  end

  def log_out!
    return nil if session[:token].nil?
    current_user.reset_session_token!
    session[:token] = nil
    session[:refreshes] = nil
  end

  def current_user
    return nil if session[:token].nil?
    unless @current_user
      @current_user = User.find_by({session_token: session[:token]})
      session[:refreshes] = session[:refreshes] ? session[:refreshes] + 1 : 0
    end
    @current_user
  end

  def current_user_id
    return nil if !@current_user
    @current_user.id
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
            :tagline, :industry, :date_of_birth, :summary, :picture)
    end
end
