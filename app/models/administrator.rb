class Administrator < ActiveRecord::Base
  has_secure_password

  validates :password, length: { minimum: 6 }, presence: { message: "Пароль повинен містити мінімум 6 символів" }
  validates :login,	presence: true
  validates :name,	presence: true, length: { minimum: 1 }
end
