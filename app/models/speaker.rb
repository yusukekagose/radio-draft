class Speaker < ApplicationRecord
  has_many :radio_speakers
  has_many :radio, through: :radio_speakers

  validates :name, presence: true

  scope :name_like, -> name {
#    where('name like ?', "%#{name}%")
    where(arel_table[:name].matches "%#{name}%")
  }
end
