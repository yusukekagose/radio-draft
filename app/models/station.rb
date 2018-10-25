class Station < ApplicationRecord

  has_many :radios

  def self.default_order
    order('lower(name) asc')
  end
end
