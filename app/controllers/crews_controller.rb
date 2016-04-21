class CrewsController < ApplicationController

  include CrewsHelper

  def index
    @crews = Crew.all
  end

  def new
    @crew = Crew.new
  end

  def show
    @crew = Crew.find(params[:id])
  end

  def create
    @crew = Crew.new(crew_params)
    if @crew.save
      redirect_to @crew
    else
      flash[:danger] = flash_errors(@crew)
      redirect_to action: 'new'
    end
  end

  def edit
    @crew = Crew.find(params[:id])
  end

  def update
  end

  def destroy
  end

  private

  def crew_params
    params.require(:crew).permit(:car_number, :vin_number)
  end
end
