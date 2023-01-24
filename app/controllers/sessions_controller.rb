# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  include AuthenticateWithOtpTwoFactor
  prepend_before_action :check_captcha, only: [:create]

  prepend_before_action :authenticate_with_otp_two_factor,
                        if: -> { action_name == 'create' && otp_two_factor_enabled? }

  protect_from_forgery with: :exception, prepend: true, except: :destroy

  private

  def check_captcha
    alert_recaptcha unless verify_recaptcha
  end

  def alert_recaptcha
    self.resource = resource_class.new(sign_in_params)
    respond_with_navigational(resource) { render(:new) }
  end
end
