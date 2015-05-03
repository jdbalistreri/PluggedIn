class Api::StaticController < ApplicationController
  before_action :require_logged_in
  
  def search
    @result_users = User
                    .user_search(params[:query])
                    .includes(:connections)
                    .page(params[:page] || 1)
                    .per(10)
    if @result_users.empty?
      @result_users = []
      @found = false
    else
      @total_count = @result_users.total_count
      @found = true
    end
  end

  def connections_search
    @user = User.find(params[:user_id])
    @connected_users = @user.connected_users
                       .includes(:connections)
                       .page(params[:page] || 1)
                       .per(6)
  end
end
