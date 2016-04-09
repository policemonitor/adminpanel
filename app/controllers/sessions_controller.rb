class SessionsController < ApplicationController
  def new
  end

  def create
    @administrator = Administrator.find_by_login(params[:session][:login])
    if @administrator && @administrator.authenticate(params[:session][:password])
      session[:administrator_id] = @administrator.id
      redirect_to root_path
    else
      flash[:danger] = "Логін або пароль не вірний"
      redirect_to login_path
    end
  end

  def destroy
    session[:administrator_id] = nil
    redirect_to root_path
  end

  def landing
  end
end
