class Access < ActiveRecord::Base
  belongs_to :claims
  before_validation :set_expiration_date
  TIME_TO_BLOCKING = 3.minutes

  validates :claim_id,
            presence: { message: " не може бути порожнім" },
            numericality: { only_integer: true }

  validates :expiration,
            presence: { message: " повинне бути задане" }

  validates_time :expiration, after: Time.now,
            :after_message => 'повинне бути у майбутньому'

  private
    def set_expiration_date
      self.expiration = Time.now + TIME_TO_BLOCKING
    end
end
