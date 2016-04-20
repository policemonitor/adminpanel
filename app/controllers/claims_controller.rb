class ClaimsController < ApplicationController
  include ClaimsHelper
  include SessionsHelper

  require 'json'

  # Not authorised users can only create claim!

  # User can only create claim. In future he will get opportunity took search
  # it's claim by entering [id + phone] combination into secrch field

  # Administrator has all privileges to manipulate claims.
  # Administrator MUST UPDATE claim after recieving it.

  before_action :signed_in_administrator, only: [:index, :edit, :update, :destroy]
  before_action :is_ADMIN, only: [:index, :edit, :update, :destroy, :map]

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

  def search
    @claim = Claim.search(params[:claim_id], params[:phone_number])
  end

  def index
    @claim = Claim.all
  end

  def map
    @claim = Claim.where(status: 'f')
    @hash = Gmaps4rails.build_markers(@claim) do |claim, marker|
      marker.lat claim.latitude
      marker.lng claim.longitude
      marker.title claim.theme
      marker.infowindow claim_card(claim)
    end
  end

  def edit
    @claim = Claim.find(params[:id])
  end

  def thankyoupage
  end

  private

  def claim_params
    params.require(:claim).permit(:lastname, :phone, :latitude, :longitude, :theme, :text)
  end
end
