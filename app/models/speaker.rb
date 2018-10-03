class Speaker < ApplicationRecord
  has_many :radio_speakers
  has_many :radio, through: :radio_speakers

  validates :name, presence: true
end
