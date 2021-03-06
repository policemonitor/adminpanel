class ClaimsController < ApplicationController
  include ClaimsHelper
  include SessionsHelper

  require 'json'

  # Not authorised users can create claim!

  # User can only create claim. In future he will get opportunity took search
  # it's claim by entering [id + phone] combination into secrch field

  # Administrator has all privileges to manipulate claims.
  # Administrator MUST UPDATE claim after recieving it.

  before_action :signed_in_administrator, only: [:all_income_claims, :edit,
                                                 :update, :destroy, :map,
                                                 :crews_list, :show, :blocked,
                                                 :assign_investigator,
                                                 :edit_assigned_investigator]

  before_action :is_ADMIN, only: [:new_claims, :all_income_claims, :crews_list,
                                                 :edit, :update, :destroy, :map]
  before_action :is_accessable, only: [:edit]
  before_action :is_blocked_by_me, only: [:update]

  def new
    @claim = Claim.new
  end

  def create
    @claim = Claim.new(claim_params)

    respond_to do |format|
      if @claim.save
        send_sms(@claim.phone, "Звернення №#{@claim.id} зареєстровано!")

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
    @paragraphs = claim_cut_to_document(@claim.text.dup.chomp)
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

  # Without search params
  def all_income_claims
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
    @default_location = { latitude: APP_CONFIG["def_lat"], longitude: APP_CONFIG["def_lng"] }
  end

  def temperature_map
    render json: Claim.select("id, theme, latitude, longitude, created_at").in_period(params[:start_date], params[:end_date]).order('created_at asc')
  end

  def edit
    @claim = Claim.find(params[:id])
    @crews = Crew.available
    @crews.each do |crew|
      crew.class.module_eval { attr_accessor :distance }
      crew.distance = Geocoder::Calculations.distance_between(
                                    [@claim.latitude, @claim.longitude],
                                    [crew.latitude, crew.longitude]).round(2)
    end

    @crews.sort_by {|crew| crew.distance}

    @hash_crews = Gmaps4rails.build_markers(@crews) do |crew, marker|
      marker.lat crew.latitude
      marker.lng crew.longitude
      marker.title "Екіпаж: #{crew.crew_name}, Відстань: #{crew.distance} км"
      marker.infowindow "Екіпаж: <b>#{crew.crew_name}</b></br>Відстань: #{crew.distance} км"
      marker.picture({
                    :url => "http://maps.google.com/mapfiles/ms/icons/blue-dot.png",
                    :width   => 32,
                    :height  => 32
                   })
    end
  end

  def assign_investigator
    if params[:id] == nil
      flash[:danger] = 'Звернення не обрано!'
      redirect_to allincomeclaims_path
    else
      @claim = Claim.find(params[:id])
      @investigators = Investigator.all
    end
  end

  def edit_assigned_investigator
    @claim = Claim.find(params[:id])
    if @claim.update_attributes(claim_update_investigator_params)
      @claim.access.delete unless @claim.access.nil?

      send_sms("Слідчий звернення №#{@claim.id}: #{@claim.investigator}")

      flash[:success] = 'Слідчого призначено!'
      redirect_to allincomeclaims_path
    else
      flash[:danger] = "Виникла помилка під час виконання!"
      redirect_to @claim
    end
  end

  def thankyoupage
  end

  def blocked
  end

  def crews_list
    @claim = Claim.find(params[:claim])
    @crews = @claim.crews
  end

  def update
    @claim = Claim.find(params[:id])
    @claim.update_attributes(status: true, administrator_id: current_administrator.id)
    if @claim.update_attributes(claim_update_params)

      @claim.crew_ids.each do |crew|
        @crew = Crew.find(crew)
        @crew.update_attribute(:on_a_mission, true)
        @crew.save
      end

      @claim.access.delete unless @claim.access.nil?

      send_sms(@claim.phone, "Звернення №#{@claim.id} розглянуто!")

      flash[:success] = 'Наказ надано! Повідомьте екіпажі!'
      redirect_to crewslist_path(claim: @claim.id), turbolinks: false
    else
      flash[:danger] = "Виникла помилка під час виконання!"
      redirect_to @claim
    end
  end

  def new_claims
    @claims = Claim.unreaded
    respond_to do |format|
      format.json { render json: @claims }
    end
  end

  private

  def send_sms(phone, text)
    begin
      client = Twilio::REST::Client.new(TWILIO_CONFIG['sid'], TWILIO_CONFIG['token'])
      client.account.sms.messages.create(
        from: TWILIO_CONFIG['from'],
        to: phone,
        body: text
      )
    rescue => e
      print "failed to send sms: " + e.message
    end
  end

  def is_blocked_by_me
    @claim = Claim.find(params[:id])
    redirect_to blocked_path(id: @claim.id) if !@claim.access.nil? && @claim.access.administrator_id != current_administrator.id
  end

  def claim_params
    params.require(:claim).permit(:lastname, :phone, :latitude, :longitude, :theme, :text)
  end

  def claim_update_params
    params.require(:claim).permit(:administrator_id, :investigator_id, crew_ids: [])
  end

  def claim_update_investigator_params
    params.require(:claim).permit(:investigator_id)
  end

  def access_params
    params.require(:access).permit(:claim_id, :administrator_id)
  end

  def is_accessable
    # if this claim is accessable -> create block row in Access and add 3 minutes expiration
    # else push a message that this page is now accessed

    claim = Claim.find(params[:id])

    if claim.access.nil?
      Access.create(claim_id: claim.id, administrator_id: current_administrator.id)
    elsif claim.access.administrator_id == current_administrator.id
      # DO not do anything, just pass it
    else
      redirect_to blocked_path(id: claim.id)
    end
  end
end
