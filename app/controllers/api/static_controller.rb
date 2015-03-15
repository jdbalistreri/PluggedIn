class Api::StaticController < ApplicationController

  def search
    found_experiences = PgSearch.multisearch(params[:query])
                        .where(searchable_type: "Experience")
                        .includes(searchable: :user)
                        .map(&:searchable)

    found_users =       PgSearch.multisearch(params[:query])
                        .where(searchable_type: "User")
                        .map(&:searchable)

    @result_users = found_experiences.map(&:user).concat(found_users).uniq
    @result_users = User.all if @result_users.empty?
  end

  def connections_search
    @user = User.find(params[:user_id])
    @connections = @user.connections
                        .where(status: 1)
                        .includes(:users)
                        .page(params[:page] || 1)
                        .per(10)
  end

end
