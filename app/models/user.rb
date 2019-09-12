class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]


  has_many :drafts
  has_many :favorites

  secret_key = [ENV["ENCRYPT_DB_SECRET_KEY"]].pack("H*")
  attr_encrypted :address, :key => secret_key
  attr_encrypted :postal_code, :key => secret_key

  enum status: { secret: 0, open: 1 }


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
