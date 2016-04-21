class CrewsController < ApplicationController
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
      redirect_to '/crews'
    else
      render 'new'
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
    params.require(:crew).permit(:lastname, :phone, :latitude, :longitude, :theme, :text)
  end
end
