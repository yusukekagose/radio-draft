class Segment < ApplicationRecord
  belongs_to :radio
  has_many :drafts

  validates :radio_id, :uniqueness => {:scope => :name}
  validates :name, presence: true
  enum status: { active: 0, end: 1 }
end
