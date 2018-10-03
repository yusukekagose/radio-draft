class Draft < ApplicationRecord
  belongs_to :radio
  belongs_to :user
  belongs_to :segment
end
