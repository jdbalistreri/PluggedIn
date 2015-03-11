class ExperiencesController < ApplicationController

  def create
    @experience = current_user.experiences.new(experience_params)

    if @experience.save
      render json: @experience
    else
      render json: @experience.errors.full_messages
    end
  end

  def destroy
    @experience = current_user.experiences.where({id: params[:id]})
    @experience.destroy()
  end

  def update
    @experience = current_user.experiences.where({id: params[:id]})

    if @experience.save
      render json: @experience
    else
      render json: @experience.errors.full_messages
    end
  end

  private
    def experience_params
      params.require(:experience).permit([:experience_type, :role, :institution,
                                          :location, :description, :start_date,
                                          :end_date, :field])
    end

end