class CrewsController < ApplicationController
  include CrewsHelper
  include SessionsHelper
  include Synchronization

  # There is no access by unauthorised persons!

  before_action :signed_in_administrator, only: [:new, :create, :edit, :update, :destroy, :fulllist, :index, :show]

  def new
    @crew = Crew.new
  end

  def create
    @crew = Crew.new(crew_params)
    if @crew.save
      if Synchronization.add_crew_to_support_server(@crew.dup)
        flash[:success] = "Новий екіпаж додано!"
        redirect_to crews_path
      else
        @crew.destroy
        flash[:danger] = "Помилка синхронізації з сервером автомобілів!"
        redirect_to crews_path
      end
    else
      flash[:danger] = flash_errors(@crew)
      redirect_to action: 'new'
    end
  end

  def index
    if params.has_key?(:query)
      @crews = Crew.search(params[:query])
    else
      @crews = Crew.where(deleted: false)
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
    rollback = {
      car_number:   @crew.car_number,
      vin_number:   @crew.vin_number,
      crew_name:    @crew.crew_name,
      on_duty:      @crew.on_duty,
      on_a_mission: @crew.on_a_mission
    }
    if @crew.update_attributes(crew_update_params)
      if Synchronization.update_crew_on_support_server(@crew.clone)
        flash[:success] = "Екіпаж оновленно!"
        redirect_to crews_path
      else
        @crew.update_attributes(rollback)

        flash[:danger] = "Помилка синхронізації з сервером автомобілів!"
        redirect_to crews_path
      end
    else
      flash[:danger] = flash_errors(@crew)
      redirect_to edit_crew_path(@crew)
    end
  end

  def destroy
    crew = Crew.find(params[:id])
    if Synchronization.destroy_crew_on_support_server(crew)
      if Crew.find(params[:id]).update_attribute(:deleted, true)
        flash[:success] = "Екіпаж розформовано!"
      else
        flash[:danger] = "Виникла помилка!"
      end
    else
      flash[:danger] = "Помилка синхронізації з сервером автомобілів!"
    end

    redirect_to crews_path
  end

  private

  def crew_params
    params.require(:crew).permit(:car_number, :vin_number, :crew_name)
  end

  def crew_update_params
    params.require(:crew).permit(:car_number, :vin_number, :crew_name, :on_duty, :on_a_mission)
  end
end
