class Claim < ActiveRecord::Base
  VALID_LASTNAME_REGEX = /\A\D{5,50}\z/
  # TELEPHONE_FORMAT_REGEX = /\A[\+]\d{1,2}[\(]\d{2,6}[\)]\d{3,10}\z/
  COORDINATES_REGEX_LATITUDE = /\A[-+]?([1-8]?\d(\.\d+)?|90(\.0+)?)\z/
  COORDINATES_REGEX_LONGITUDE = /\A[-+]?(180(\.0+)?|((1[0-7]\d)|([1-9]?\d))(\.\d+)?)\z/

  phony_normalize :phone, default_country_code: 'UA'

  has_and_belongs_to_many :crews
  belongs_to :administrators
  has_one :access

  validates :lastname,
            presence: { message: " не може бути порожнім" },
            length: { minimum: 5, message: " закоротке" },
            format: { with: VALID_LASTNAME_REGEX, message: " містить неприпустимі символи" }

  validates_plausible_phone :phone, country_code: 'UA'

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
      where(id: claim_id, phone: phone_number).first
    else
      nil
    end
  end
end
