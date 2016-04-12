class ClaimsController < ApplicationController

  def new
    @claim = Claim.new
  end

  def create
    @claim = Claim.new(claim_params)
    if @claim.save
      flash[:success] = "Ваша заява прийнята! Дякуємо за допомогу!"
      # In feature should redirect to "Thank you!" page
      redirect_to root_path
    else
      flash[:danger] = "Виникли певні помилки"
      redirect_to new_claim_path_path
    end
  end

  def show
    @claim = Claim.find(params[:id])
  end

  def edit
    @claim = Claim.find(params[:id])
  end

  private

  def claim_params
    params.require(:claim).permit(:lastname, :phone, :latitude, :longitude, :theme, :text)
  end
end
