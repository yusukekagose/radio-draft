class RadioSpeaker < ApplicationRecord
  belongs_to :radio
  belongs_to :speaker

  validates :radio_id, :uniqueness => {:scope => :speaker_id}


end
