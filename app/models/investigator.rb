class Investigator < ActiveRecord::Base
  has_many :claims

  def self.search(query)
    if query != ''
      where("lastname LIKE ?", "%#{query}%")
    else
      all
    end
  end
end
