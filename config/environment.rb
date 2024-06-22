# Load the Rails application.
require_relative "application"


ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  port: ENV['SMTP_PORT'],
  address: ENV['SMTP_SERVER'],
  user_name: ENV['SMTP_LOGIN'],
  password: ENV['SMTP_PASSWORD'],
  authentication: :login,
  enable_starttls_auto: true
}

# Initialize the Rails application.
Rails.application.initialize!
