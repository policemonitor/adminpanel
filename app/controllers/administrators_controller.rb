class AdministratorsController < ApplicationController
  include AdministratorsHelper

  def new
    @administrator = Administrator.new
  end

  def index
    @administrators = Administrator.all
  end

  def create
    @administrator = Administrator.new(administrator_params)
    @errors = @administrator.errors
    if @administrator.save
      session[:administrator_id] = @administrator.id
      redirect_to administrators_path
    else
      flash[:danger] = flash_errors(@administrator)
      redirect_to signup_path
    end
  end

  def show
    @administrator = current_administrator
  end

  private

  def administrator_params
    params.require(:administrator).permit(:lastname, :login, :password)
  end
end
