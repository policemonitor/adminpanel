class CrewsController < ApplicationController
  include CrewsHelper
  include SessionsHelper

  # There is no access by unauthorised persons!

  before_action :signed_in_administrator, only: [:new, :create, :edit, :update, :destroy, :fulllist]
  before_action :is_ADMIN, only: [:new, :create, :edit, :update, :destroy, :fulllist]

  def new
    @crew = Crew.new
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

  def index
    if (params.has_key?(:query))
      @crews = Crew.search(params[:query])
    else
      @crews = Crew.all
    end
  end

  def fulllist
    @crews = Crew.all
  end

  def show
    @crew = Crew.find(params[:id])
  end

  def edit
    @crew = Crew.find(params[:id])
  end

  def update
    @crew = Crew.find(params[:id])
    if @crew.update_attributes(crew_update_params)
      flash[:success] = 'Обліковий запис змінено'
      redirect_to crew_path
    else
      flash[:danger] = flash_errors(@crew)
      redirect_to edit_crew_path(@crew)
    end
  end

  def destroy
  end

  private

  def crew_params
    params.require(:crew).permit(:car_number, :vin_number, :crew_name)
  end

  def crew_update_params
    params.require(:crew).permit(:car_number, :vin_number, :crew_name, :on_duty, :on_a_mission)
  end
end
