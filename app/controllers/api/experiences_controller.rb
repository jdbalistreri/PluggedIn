class Api::ExperiencesController < ApplicationController

  def create
    @experience = current_user.experiences.new(experience_params)

    @experience.end_date = nil if params['experience']['check_present']

    if @experience.save
      render :partial => "api/shared/experience",
             :locals => { experience: @experience }
    else
      render json: @experience.errors.full_messages,
             status: :unprocessable_entity
    end
  end

  def destroy
    @experience = current_user.experiences.find(params[:id])
    @experience.destroy!
    render json: 'success'
  end

  def show
    @experience = current_user.experiences.find(params[:id])
    render :partial => "api/shared/experience",
           :locals => { experience: @experience }
  end

  def update
    @experience = current_user.experiences.find(params[:id])
    @experience.assign_attributes(experience_params)

    @experience.end_date = nil if params['experience']['check_present']

    if @experience.save
      render :partial => "api/shared/experience",
             :locals => { experience: @experience }
    else
      render json: @experience.errors.full_messages,
             status: :unprocessable_entity
    end
  end

  private

    def experience_params
      params.require(:experience).permit(:experience_type, :role, :institution,
                                         :location, :description, :start_date,
                                         :end_date, :field)
    end
end
