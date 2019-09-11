class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]


  has_many :drafts
  has_many :favorites

  before_save :encrypt_data

  enum status: { secret: 0, open: 1 }

  require 'digest'
  SECURE = Digest::MD5.hexdigest(ENV['SECURE'])
  CIPHER = ENV['CIPHER']

  def encrypt_data
    self.address = encrypt(self.address)
    self.postal_code = encrypt(self.postal_code)
    self.send_from = encrypt(self.send_from)
  end

  def encrypt(obj)
    crypt = ActiveSupport::MessageEncryptor.new(SECURE, CIPHER)
    crypt.encrypt_and_sign(obj)
  end

  def decrypt(obj)
    crypt = ActiveSupport::MessageEncryptor.new(SECURE, CIPHER)
    crypt.decrypt_and_verify(obj)
  end


  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    # binding.pry
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.image = auth.info.image
    end
  end

end
