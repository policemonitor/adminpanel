class InvestigatorsController < ApplicationController
  include SessionsHelper
  before_action :signed_in_administrator, only: [:index]

  def index
    @investigators = Investigator.search(params[:query])
  end
end
