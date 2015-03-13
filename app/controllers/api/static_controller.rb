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
  end

end
