class AdministratorsController < ApplicationController
  def new
    @administrator = Administrator.new
  end

  def index
    @administrators = Administrator.all
  end

  def create
    @administrator = Administrator.new(administrator_params)
    if @administrator.save
      session[:administrator_id] = @administrator.id
      redirect_to administrators_path
    else
      redirect_to signup_path
    end
end

def show
end

  private

  def administrator_params
    params.require(:administrator).permit(:name, :login, :password)
  end
end
