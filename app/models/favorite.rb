class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :radio
  validates :user_id, :uniqueness => {:scope => :radio_id}
end
