class ClaimsController < ApplicationController
  include ClaimsHelper
  include SessionsHelper

  require 'json'

  # Not authorised users can only create claim!

  # User can only create claim. In future he will get opportunity took search
  # it's claim by entering [id + phone] combination into secrch field

  # Administrator has all privileges to manipulate claims.
  # Administrator MUST UPDATE claim after recieving it.

  before_action :signed_in_administrator, only: [:all_income_claims, :edit, :update, :destroy]
  before_action :is_ADMIN, only: [:all_income_claims, :edit, :update, :destroy, :map]

  def new
    @claim = Claim.new
  end

  def create
    @claim = Claim.new(claim_params)

    respond_to do |format|
      if @claim.save
        format.html do
          redirect_to thanks_path(id: @claim.id)
        end
        format.json do
          render json: { claim_id: @claim.id, phone: @claim.phone }, status: :created
        end
      else
        format.html do
          redirect_to new_claim_path
          flash[:danger] = flash_errors(@claim)
        end
        format.json do
          render json: @claim.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def show
    @claim = Claim.find(params[:id])
  end

  def index
    @claim = Claim.search(params[:claim_id], params[:phone_number])
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'report', template: 'claims/pdf.html.erb', encoding: 'utf8'
      end
    end
  end

  def all_income_claims
    @claim = Claim.all
  end

  def map
    @claim = Claim.where(status: 'f')
    @hash = Gmaps4rails.build_markers(@claim) do |claim, marker|
      marker.lat claim.latitude
      marker.lng claim.longitude
      marker.title claim.theme
      marker.infowindow claim_card(claim, false)
    end
  end

  def edit
    @claim = Claim.find(params[:id])
  end

  def thankyoupage
  end

  def crews_list
    @claim = Claim.find(params[:claim])
    @crews = @claim.crews
  end

  def update
    @claim = Claim.find(params[:id])
    @claim.status = true
    @claim.administrator_id = current_administrator.id
    if @claim.update_attributes(claim_update_params)

      @claim.crew_ids.each do |crew|
        @crew = Crew.find(crew)
        @crew.on_a_mission = true
        @crew.save
      end

      flash[:success] = 'Наказ надано! Повідомьте екіпажі!'
      redirect_to crews_list_path(claim: @claim.id)
    else
      flash[:danger] = "Виникла помилка під час виконання!"
      redirect_to @claim
    end
  end

  private

  def claim_params
    params.require(:claim).permit(:lastname, :phone, :latitude, :longitude, :theme, :text)
  end

  def claim_update_params
    params.require(:claim).permit(crew_ids: [])
  end
end
