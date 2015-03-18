class Api::StaticController < ApplicationController

  def search
    found_experiences = PgSearch.multisearch(params[:query])
                        .where(searchable_type: "Experience")
                        .includes(searchable: {user: :connections})
                        .map(&:searchable)

    found_users =       PgSearch.multisearch(params[:query])
                        .where(searchable_type: "User")
                        .includes(searchable: :connections)
                        .map(&:searchable)

    @result_users = found_experiences.map(&:user).concat(found_users).uniq
    @result_users = User.all.includes(:connections) if @result_users.empty?
  end

  def connections_search
    @user = User.find(params[:user_id])
      @connected_users = @user.connected_users
                          .includes(:connections)
                          .page(params[:page] || 1)
                          .per(6)
  end

end
