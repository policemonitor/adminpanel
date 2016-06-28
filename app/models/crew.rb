class Crew < ActiveRecord::Base
  VALID_CARS_NUMBER = /\A[A-Z]{2}[\d]{4}[A-Z]{2}\z/
  VALID_VIM_NUM_REGEX = /\A\w{15,20}\z/
  VALID_CREW_NAME = /\A[0-9]{4}\z/
  COORDINATES_REGEX_LATITUDE = /\A[-+]?([1-8]?\d(\.\d+)?|90(\.0+)?)\z/
  COORDINATES_REGEX_LONGITUDE = /\A[-+]?(180(\.0+)?|((1[0-7]\d)|([1-9]?\d))(\.\d+)?)\z/


  has_and_belongs_to_many :claims

  validates :car_number,
            presence: { message: " не може бути порожньою" } ,
            uniqueness:  {case_sensitive: false, message: " вже зареєстровано"},
            format: { with: VALID_CARS_NUMBER, message: "має неправильний формат" }

  validates :vin_number,
            presence: { message: " не може бути порожнім" },
            uniqueness:  {case_sensitive: false, message: " вже зареєстровано"},
            format: { with: VALID_VIM_NUM_REGEX, message: "має неправильний формат" }

  validates :crew_name,
            presence: { message: " не може бути порожнім" },
            uniqueness:  {case_sensitive: false, message: " вже зареєстровано"},
            format: { with: VALID_CREW_NAME, message: "має неправильний формат" }

  validates :on_duty, :inclusion => {:in => [true, false], message: "має неправильний формат"}

  validates :on_a_mission, :inclusion => {:in => [true, false], message: "має неправильний формат"}

  def self.search query
    if query != ''
      where("car_number = ? OR vin_number = ? OR crew_name = ? OR id = ?", query, query, query, query)
    else
      all
    end
  end

  def self.update_coordinates name, vin, number, latitude, longitude
    car = extract_crew name, vin, number
    if (validate_coordinates? latitude, longitude) && !car.nil?
      car.update_attributes latitude: latitude, longitude: longitude
      return true
    else
      return false
    end
  end

  private
    def self.validate_coordinates? latitude, longitude
      return (latitude.to_s =~ COORDINATES_REGEX_LATITUDE && longitude.to_s =~ COORDINATES_REGEX_LONGITUDE) ? true : false
    end

    def self.extract_crew name, vin, number
      find_by("car_number = ? AND vin_number = ? AND crew_name = ?", number, vin, name)
    end

end
