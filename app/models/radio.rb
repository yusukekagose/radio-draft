class Radio < ApplicationRecord
  belongs_to :station
  has_many :drafts
  has_many :radio_speakers
  has_many :speakers, through: :radio_speakers
  has_many :segments
  accepts_nested_attributes_for :speakers

  validates :name, presence: true

  #create speaker only when speaker does'n exist
  def speakers_attributes=(speaker_attributes)
    speaker_attributes.values.each do |speaker_attribute|
      speaker = Speaker.find_or_create_by(speaker_attribute)
      self.speakers << speaker
    end
  end

  def self.search param
    param.strip!
  end

end
