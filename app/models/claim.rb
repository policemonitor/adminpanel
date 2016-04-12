class Claim < ActiveRecord::Base
  TELEPHONE_FORMAT_REGEX = /[\+]\d{1,2}[\(]\d{2,6}[\)]\d{3,10}/
end
