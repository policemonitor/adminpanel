class ClaimsController < ApplicationController
  include ClaimsHelper

  def new
    @claim = Claim.new
  end

  def create
    @claim = Claim.new(claim_params)

    respond_to do |format|
      if @claim.save
        format.html do
          redirect_to acceptedclaim_path
          flash[:success] = "Ваша заява прийнята! Дякуємо за допомогу!"
        end
        format.json do
          render json: @claim, status: :created, location: @claim
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
