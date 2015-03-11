class Api::ExperiencesController < ApplicationController

  def create
    @experience = current_user.experiences.new(experience_params)

    if @experience.save
      render json: @experience
    else
      render json: @experience.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @experience = current_user.experiences.find(params[:id])
    @experience.destroy!
    render json: "success"
  end

  def update
    @experience = current_user.experiences.find(params[:id])

    if @experience.update(experience_params)
      render json: @experience
    else
      render json: @experience.errors.full_messages, status: :unprocessable_entity
    end
  end

  private
    def experience_params
      params.require(:experience).permit(:experience_type, :role, :institution,
                                          :location, :description, :start_date,
                                          :end_date, :field)
    end

end
