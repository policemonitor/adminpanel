module Synchronization

  # Inter-server synchronization
  # See notices in 'schedule.rb'

  require 'json'
  CARS_SERVER_ADDRESS = "http://localhost:5000/cars.json"

  def self.add_crew_to_support_server(car)
    uri = URI.parse(CARS_SERVER_ADDRESS)

    post_params = {
      :car_number => car.car_number,
      :crew_name  => car.crew_name,
      :vin_number => car.vin_number
    }

    req = Net::HTTP::Post.new(uri.path)
    req.body = JSON.generate(post_params)
    req["Content-Type"] = "application/json"
    req["Accept"] = "application/json"

    begin
      http = Net::HTTP.new(uri.host, uri.port)
      response = http.start {|htt| htt.request(req)}
    rescue StandardError
      Rails.logger.error "Unnable to POST information from cars server! (#{CARS_SERVER_ADDRESS})"
      return false
    end
      Rails.logger.info "Synchronization is succesfull!"
      return true
  end

  def self.daemon_synchronize
    require 'open-uri'
    begin
      requests = JSON.load(open(CARS_SERVER_ADDRESS))

    rescue StandardError
      Rails.logger.error "Unnable to fetch information from cars server #{CARS_SERVER_ADDRESS} !"
      Rails.logger.info  "Using old data about crews!"
      return false
    end

    requests.each do |request|
      Rails.logger.info  "Updating car with VIN #{request["details"]["vin_number"]}"
      crew = Crew.find_by(
                          crew_name: request["car"],
                          vin_number: request["details"]["vin_number"],
                          car_number: request["details"]["car_number"]
                       )
      if !crew.nil?
        crew.update_attributes(
                          longitude: request["details"]["longitude"],
                          latitude: request["details"]["latitude"]
                       )

        Rails.logger.info "Crews #{request["car"]} coordinates succesfully updated!"
      else
        Rails.logger.error "There is no such car with VIN  #{request["details"]["vin"]}!"
      end
    end
  end
end
