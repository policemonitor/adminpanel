class Claim < ActiveRecord::Base
  VALID_LASTNAME_REGEX = /\D{5,50}/
  TELEPHONE_FORMAT_REGEX = /[\+]\d{1,2}[\(]\d{2,6}[\)]\d{3,10}/
  COORDINATES_REGEX_LATITUDE = /[-+]?([1-8]?\d(\.\d+)?|90(\.0+)?)/
  COORDINATES_REGEX_LONGITUDE = /[-+]?(180(\.0+)?|((1[0-7]\d)|([1-9]?\d))(\.\d+)?)/

  HUMANIZED_ATTRIBUTES = {
    lastname: "ПІБ",
    phone: "Телефон",
    theme: "Тема звернення",
    text: "Текст звернення",
    latitude: "Широта",
    longitude: "Довгота"
  }.freeze

  validates :lastname,
            presence: { message: " не може бути порожнім" },
            length: { minimum: 5, message: " закоротке" },
            format: { with: VALID_LASTNAME_REGEX, message: " містить неприпустимі символи" }

  validates :phone,
            presence: { message: " не може бути порожнім" },
            format: { with: TELEPHONE_FORMAT_REGEX, message: " має невірний формат" }

  validates :theme,
            presence: { message: " не може бути порожньою" }

  validates :text,
            presence: { message: " не може бути порожнім" }

  validates :latitude,
            presence: { message: " не може бути порожньою" },
            format: { with: COORDINATES_REGEX_LATITUDE, message: " має неприпустимий формат" }

  validates :longitude,
            presence: { message: " не може бути порожньою" },
            format: { with: COORDINATES_REGEX_LONGITUDE, message: " має неприпустимий формат" }

  def self.search(claim_id, phone_number)
    if claim_id && phone_number
      where(id: claim_id, phone: phone_number)
    else
      nil
    end
  end
end
