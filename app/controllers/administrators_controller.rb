class AdministratorsController < ApplicationController
  def new
    @administrator = Administrator.new
  end

  def create
    @administrator = Administrator.new(administrator_params)
    if @administrator.save
      session[:administrator_id] = @administrator.id
      redirect_to '/'
    else
      redirect_to '/signup'
    end
end

  private

  def administrator_params
    params.require(:administrator).permit(:name, :login, :password)
  end
end
