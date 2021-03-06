class AdministratorsController < ApplicationController
  include AdministratorsHelper
  include SessionsHelper

  # Not authorised users can only create claim!

  # Administrator's profile can be viewed only by current administrator
  # Administrator's profile can be changed only by him self or buy HR
  # New administrator can be added only by HR
  # List of administrators can only been viewed by HR
  # Any special features for administrators cannot be accessed by HR

  before_action :signed_in_administrator, only: [:edit, :update, :show, :new, :index, :destroy]
  before_action :correct_administrator,   only: [:edit, :update, :show]
  before_action :correct_hr,              only: [:new, :index, :destroy]

  def new
    @administrator = Administrator.new
  end

  def index
    @administrators = Administrator.where(fired: false)
  end

  def create
    @administrator = Administrator.new(administrator_params)
    if @administrator.save
      # session[:administrator_id] = @administrator.id
      redirect_to @administrator
    else
      flash[:danger] = flash_errors(@administrator)
      redirect_to signup_path
    end
  end

  def show
    @administrator = Administrator.find(params[:id])
  end

  def edit
    @administrator = Administrator.find(params[:id])
  end

  def update
    @administrator = Administrator.find(params[:id])
    if @administrator.update_attributes(administrator_params)
      flash[:success] = 'Обліковий запис змінено'
      redirect_to @administrator
    else
      flash[:danger] = flash_errors(@administrator)
      redirect_to edit_administrator_path(@administrator)
    end
  end

  def destroy
    if Administrator.find(params[:id]).update_attribute(:fired, true)
      flash[:success] = "Співробітника звільнено!"
    else
      flash[:danger] = "Виникла помилка!"
    end

    redirect_to administrators_path
  end

  private

  def administrator_params
    params.require(:administrator).permit(:lastname, :personal_number, :rank, :login, :password)
  end

  def correct_administrator
    @administrator = Administrator.find(params[:id])
    if current_administrator.rank != HR_RANK
      unless current_administrator?(@administrator)
        flash[:danger] = 'Немає прав на виконання цієї операції!'
        redirect_to login_path
      end
    end
  end

  def correct_hr
    if current_administrator.rank != HR_RANK
      flash[:danger] = 'Немає прав на виконання цієї операції!'
      redirect_to login_path
    end
  end
end
