class Radio < ApplicationRecord
  belongs_to :station
  has_many :drafts

  validates :name, presence: true
end
