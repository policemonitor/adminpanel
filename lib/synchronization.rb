module Synchronization

  # Inter-server synchronization
  # See notices in 'schedule.rb'

  require 'json'
  CARS_SERVER_ADDRESS = APP_CONFIG["car_server_address"]
  SYNCHRONIZATION_KEY = APP_CONFIG["access_token"]

  CREATE_SUCCEED_STATUS = 201
  UPDATE_SUCCEED_STATUS = 204

  def self.add_crew_to_support_server(car)
    uri = URI.parse(CARS_SERVER_ADDRESS)

    post_params = {
      car_number: car.car_number,
      car_name:   car.crew_name,
      vin_number: car.vin_number,
      key:        SYNCHRONIZATION_KEY
    }

    req = Net::HTTP::Post.new(uri.path)
    req.body = JSON.generate(post_params)
    req["Content-Type"] = "application/json"
    req["Accept"] = "application/json"

    begin
      http = Net::HTTP.new(uri.host, uri.port)
      response = http.start {|htt| htt.request(req)}

      raise "An error occured while trying POST information on neigbor server!" if response.code.to_i != CREATE_SUCCEED_STATUS

    rescue
      Rails.logger.error "Unnable to POST information on cars server! (#{CARS_SERVER_ADDRESS})"
      return false
    end
      Rails.logger.info "Synchronization is succesfull!"
      return true
  end

  def self.update_crew_on_support_server(car)
    car_identifier = CARS_SERVER_ADDRESS + "/cars/" + car.id.to_s + ".json"
    uri = URI.parse(car_identifier)

    post_params = {
      car_number:   car.car_number,
      car_name:     car.crew_name,
      vin_number:   car.vin_number,
      on_duty:      car.on_duty,
      on_a_mission: car.on_a_mission,
      key:          SYNCHRONIZATION_KEY
    }

    req = Net::HTTP::Put.new(uri.path)
    req.body = JSON.generate(post_params)
    req["Content-Type"] = "application/json"
    req["Accept"] = "application/json"

    begin
      http = Net::HTTP.new(uri.host, uri.port)
      response = http.start {|htt| htt.request(req)}

      raise "An error occured while trying UPDATE information on neigbor server!" if response.code.to_i != UPDATE_SUCCEED_STATUS
    rescue
      Rails.logger.error "Unnable to UPDATE information on cars server to update #{car.crew_name}! (#{car_identifier})"
      return false
    end
      Rails.logger.info "Synchronization is succesfull! (Car #{car.crew_name} updated)"
      return true
  end

  def self.destroy_crew_on_support_server(car)
    car_identifier = CARS_SERVER_ADDRESS + "/cars/" + car.id.to_s + ".json"
    uri = URI.parse(car_identifier)

    delete_params = {
      key:          SYNCHRONIZATION_KEY
    }

    req = Net::HTTP::Delete.new(uri.path)
    req.body = JSON.generate(delete_params)
    req["Content-Type"] = "application/json"
    req["Accept"] = "application/json"

    begin
      http = Net::HTTP.new(uri.host, uri.port)
      response = http.start {|htt| htt.request(req)}

      raise "An error occured while trying UPDATE information on neigbor server!" if response.code.to_i != UPDATE_SUCCEED_STATUS
    rescue
      Rails.logger.error "Unnable to DESTROY crew on suport server #{car.crew_name}! (#{car_identifier})"
      return false
    end
      Rails.logger.info "Synchronization is succesfull! (Car #{car.crew_name} deleted)"
      return true
  end

  def self.daemon_synchronize
    require 'open-uri'
    begin
      requests = JSON.load(open(CARS_SERVER_ADDRESS + "?key=" + SYNCHRONIZATION_KEY))

    rescue StandardError
      Rails.logger.error "Unnable to fetch information on cars server #{CARS_SERVER_ADDRESS} !"
      Rails.logger.info  "Using old data about crews!"
      return false
    end

    Rails.logger.info  "Synchronization started at #{Time.now}"

    requests.each do |request|
      Rails.logger.info  "Updating car with VIN #{request["details"]["vin_number"]}"
      status = Crew.update_crew request["car"],
                                       request["details"]["vin_number"],
                                       request["details"]["car_number"],
                                       request["details"]["latitude"],
                                       request["details"]["longitude"],
                                       request["statuses"]["on_duty"],
                                       request["statuses"]["on_a_mission"]
      if status
        Rails.logger.info "Crews #{request["car"]} coordinates succesfully updated!"
      else
        Rails.logger.error "There is no such car with VIN  #{request["details"]["vin"]}!"
      end
    end
  end

  def self.daemon_unlock
    Rails.logger.error "Unlocker has started! (#{Time.now})"
    access = Access.all
    Rails.logger.error "Found #{access.count} bloked claims."

    access.each do |claim|
      Rails.logger.error "Checking claim #{claim.claim_id}"
      if claim.expiration < Time.now
        Rails.logger.error "Unlocking claim."
        claim.delete
        access.save
      else
        Rails.logger.error "Will be unlocked on #{claim.expiration}"
      end
    end
  end
end
