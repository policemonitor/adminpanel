class Crew < ActiveRecord::Base
  VALID_CARS_NUMBER = /[A-Z]{2}[\d]{4}[A-Z]{2}/
  VALID_VIM_NUM_REGEX = /\w{15,20}/
  VALID_CREW_NAME = /[0-9]{4}/

  validates :car_number,
            presence: { message: " не може бути порожньою" } ,
            format: { with: VALID_CARS_NUMBER, message: "має неправильний формат" }

  validates :vin_number,
            presence: { message: " не може бути порожнім" },
            format: { with: VALID_VIM_NUM_REGEX, message: "має неправильний формат" }

  validates :crew_name,
            presence: { message: " не може бути порожнім" },
            format: { with: VALID_CREW_NAME, message: "має неправильний формат" }

  validates :on_duty, :inclusion => {:in => [true, false], message: "має неправильний формат"}

  validates :on_a_mission, :inclusion => {:in => [true, false], message: "має неправильний формат"}

  def self.search(query)
    if query != ''
      where("car_number = ? OR vin_number = ?", query, query)
    else
      all
    end
  end

end
