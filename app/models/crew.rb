class Crew < ActiveRecord::Base
  VALID_CAR_NUM_REGEX = /[А-Я]{2}\d{4}[А-Я]{2}/
  VALID_VIM_NUM_REGEX = /\d{4}/

  validates :car_number,
            presence: { message: " не може бути порожнім" },
            format: { with: VALID_CAR_NUM_REGEX, message: "неправильний формат" }

  validates :vin_number,
            presence: { message: " не може бути порожнім" },
            length: { minimum: 5, message: " закоротке" },
            format: { with: VALID_VIM_NUM_REGEX, message: "неправильний формат" }
end
