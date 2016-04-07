class Administrator < ActiveRecord::Base
  has_secure_password

  validates :password,
              presence: {message: " повинен містити не менш ніж 6 символів"},
              length: {minimum: 6, message: " закороткий"}

  validates :login,
              presence: {message: " не може бути порожнім"},
              uniqueness:  {case_sensitive: false, message: " вже зайнято" }

  validates :name,
              presence: {message: " не може бути порожнім"},
              length: { minimum: 3, message: " закоротке"}
end
