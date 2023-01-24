# frozen_string_literal: true

Recaptcha.configure do |config|
  Recaptcha.configuration.skip_verify_env.delete('teste')

  config.site_key = ENV['CAPTCHA_SITE_KEY']
  config.secret_key = ENV['CAPTCHA_SECRET_KEY']
end
