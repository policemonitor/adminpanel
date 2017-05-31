class CrewsController < ApplicationController
  include CrewsHelper
  include SessionsHelper

  # There is no access by unauthorised persons!
  before_action :signed_in_administrator, only: [:new, :create, :edit, :update, :destroy, :fulllist, :index, :show, :live_map, :api_live_map]

  # Request new info before map update
  before_action :get_markers, only: [:live_map, :api_live_map]

  def new
    @crew = Crew.new
  end

  def create
    @crew = Crew.new(crew_params)
    if @crew.save
        flash[:success] = "Новий запис додано!"
        redirect_to crews_path
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
    if @crew.update_attributes(crew_update_params)
      flash[:success] = "Екіпаж оновленно!"
      redirect_to crews_path
    else
      flash[:danger] = flash_errors(@crew)
      redirect_to edit_crew_path(@crew)
    end
  end

  def destroy
    crew = Crew.find(params[:id])
    if Crew.find(params[:id]).update_attribute(:deleted, true)
      flash[:success] = "Екіпаж розформовано!"
    else
      flash[:danger] = "Виникла помилка!"
    end

    redirect_to crews_path
  end

  # Map with live reload

  def live_map
  end

  def api_live_map
    render json: @hash
  end

  def get_markers
    @cars = Crew.where(deleted: false)
    @hash = Gmaps4rails.build_markers(@cars) do |car, marker|
      marker.lat car.latitude
      marker.lng car.longitude
      marker.title "Екіпаж: #{car.crew_name}"
      marker.infowindow "Екіпаж #{car.crew_name}, держ. знак #{car.car_number}"
      marker.picture({
                         :url => "https://mt.googleapis.com/vt/icon/name=icons/onion/27-cabs.png",
                         :width => 32,
                         :height => 32
                     })
    end
  end

  private

  def crew_params
    params.require(:crew).permit(:car_number, :vin_number, :crew_name)
  end

  def crew_update_params
    params.require(:crew).permit(:car_number, :vin_number, :crew_name, :on_duty, :on_a_mission)
  end
end
