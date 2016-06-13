class Administrator < ActiveRecord::Base
  include SessionsHelper

  has_secure_password
  has_many :claims
  VALID_PERSONAL_NUMBER_REGEX = /\A\d{7}\z/                                         # Personal number is 7 digits number
  VALID_LASTNAME_REGEX = /\A\D{5,50}\z/

  validates :lastname,
              presence: {message: " не може бути порожнім"},
              length: { minimum: 5, message: " закоротке"},
              format: {with: VALID_LASTNAME_REGEX, message: " містить неприпустимі символи"}

  validates :personal_number,
              presence: {message: " не може бути порожнім"},
              uniqueness:  {case_sensitive: false, message: " вже зареєстровано"},
              format: {with: VALID_PERSONAL_NUMBER_REGEX, message: " має не вірний формат"}

  validates :rank,
              presence: {message: " повинен бути вказаний"},
              inclusion: {in: [ADMIN_RANK, HR_RANK], message: " не існує"}

  validates :login,
              presence: {message: " не може бути порожнім"},
              uniqueness:  {case_sensitive: false, message: " вже зайнято"}

  validates :password,
              presence: {message: " повинен містити не менш ніж 6 символів"},
              length: {minimum: 6, message: " закороткий"}
end
