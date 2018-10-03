class Segment < ApplicationRecord
  belongs_to :radio
  has_many :drafts

  validates :radio_id, :uniqueness => {:scope => :name}
end
