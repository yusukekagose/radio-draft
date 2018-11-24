# frozen_string_literal: true

# Use this hook to configure devise mailer, warden hooks and so forth.
# Many of these configuration options can be set straight in your model.
Devise.setup do |config|
  
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'

  
  require 'devise/orm/active_record'

  
  config.case_insensitive_keys = [:email]

  # Configure which authentication keys should have whitespace stripped.
  # These keys will have whitespace before and after removed upon creating or
  # modifying a user and when used to authenticate or find a user. Default is :email.
  config.strip_whitespace_keys = [:email]

  
  config.skip_session_storage = [:http_auth]

  
  config.stretches = Rails.env.test? ? 1 : 11

  config.reconfirmable = true

  config.expire_all_remember_me_on_sign_out = true

  config.password_length = 6..128

  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  config.reset_password_within = 6.hours

  config.sign_out_via = [:get, :delete]

  require 'omniauth-facebook'
  config.omniauth :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'], scope: 'email', info_fields: 'email, name'
end
