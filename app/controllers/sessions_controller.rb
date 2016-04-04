class SessionsController < ApplicationController
  def new
  end

  def create
    @administrator = Administrator.find_by_login(params[:session][:login])
    if @administrator && @administrator.authenticate(params[:session][:password])
      session[:administrator_id] = @administrator.id
      redirect_to '/'
    else
      redirect_to 'login'
    end
  end

  def destroy
    session[:administrator_id] = nil
    redirect_to '/'
  end
end
