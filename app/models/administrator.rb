class Administrator < ActiveRecord::Base
  has_secure_password

  validates :password,	presence: true, length: { minimum: 6 }, message: "Пароль повинен містити більше 6 символів"
  validates :login,	presence: true, message: "Логін не може бути пустим"
  validates :name,	presence: true, length: { minimum: 1 }, message: "Ім’я не може бути пустим"
end
