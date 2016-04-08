class Administrator < ActiveRecord::Base
  has_secure_password
  VALID_PERSONAL_NUMBER_REGEX = /\d{7}/                                         # Personal number is 7 digits number

  validates :lastname,
              presence: {message: " не може бути порожнім"},
              length: { minimum: 3, message: " закоротке"}

  validates :personal_number,
              presence: {message: " не може бути порожнім"},
              uniqueness:  {case_sensitive: false, message: " вже зареєстровано"},
              format: {with: VALID_PERSONAL_NUMBER_REGEX, message: " має не вірний формат"}

  validates :rank,
              presence: {message: " повинен бути вказаний"}

  validates :login,
              presence: {message: " не може бути порожнім"},
              uniqueness:  {case_sensitive: false, message: " вже зайнято"}

  validates :password,
              presence: {message: " повинен містити не менш ніж 6 символів"},
              length: {minimum: 6, message: " закороткий"}
end
