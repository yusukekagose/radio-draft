class Draft < ApplicationRecord
  belongs_to :radio
  belongs_to :user
  belongs_to :segment, optional: true

  enum status: { draft: 0, sent: 1 }

end
