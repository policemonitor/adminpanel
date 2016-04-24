class Crew < ActiveRecord::Base
  VALID_CARS_NUMBER = /[A-Z]{2}[\d]{4}[A-Z]{2}/
  VALID_VIM_NUM_REGEX = /\d{4}/

  validates :car_number,
            presence: { message: " не може бути порожнім" } ,
            format: { with: VALID_CARS_NUMBER, message: "має неправильний формат" }

  validates :vin_number,
            presence: { message: " не може бути порожнім" },
            format: { with: VALID_VIM_NUM_REGEX, message: "має неправильний формат" }
end
