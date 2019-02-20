class Radio < ApplicationRecord
  belongs_to :station, optional: true
  has_many :drafts
  has_many :radio_speakers
  has_many :speakers, through: :radio_speakers
  has_many :segments
  has_many :favorites
  accepts_nested_attributes_for :speakers

  validates :name, presence: true, uniqueness: true

  after_create :get_img

  def get_img
    options = {}
    options[:searchType] = "image"
    radio_name = self.name + "ラジオ"

    results = GoogleCustomSearchApi.search(radio_name, options)
    begin
      img = results.items[1].link
    rescue => e
      img = ""
    end

    self.update(img: img)
  end

  #create speaker only when speaker does'n exist
  def speakers_attributes=(speaker_attributes)
    speaker_attributes.values.each do |speaker_attribute|
      speaker = Speaker.find_or_create_by(speaker_attribute)
      self.speakers << speaker
    end
  end


  def self.order_by_drafts_count
    joins(:drafts).group("radios.id").order("count(radios.id) DESC")
  end

  def self.order_by_favorites_count
    joins(:favorites).group("radios.id").order("count(radios.id) DESC")
  end

  def self.search keyword
    keyword.strip!
    keyword.downcase!

    (search_by_name(keyword) + search_by_speakers(keyword) + search_by_station(keyword)).uniq
  end

  def self.search_by_station keyword
    where(station: Station.where("lower(name) like ?", "%#{keyword}%"))
  end

  def self.search_by_speakers keyword
    eager_load(:speakers).where("speakers.name like ?", "%#{keyword}%")
  end

  def self.search_by_name keyword
    matches('name', keyword)
  end

  def self.matches(field_name, param)
    where("#{field_name} like ?", "%#{param}%")
  end

end
