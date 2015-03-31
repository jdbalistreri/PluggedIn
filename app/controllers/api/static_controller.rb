class Api::StaticController < ApplicationController

  def search
    @result_users = User.user_search(params[:query]).includes(:connections).page(params[:page] || 1).per(10)
    @result_users = User.all.includes(:connections).page(1).per(10) if @result_users.empty?
  end

  def connections_search
    @user = User.find(params[:user_id])
      @connected_users = @user.connected_users
                          .includes(:connections)
                          .page(params[:page] || 1)
                          .per(6)
  end

end
