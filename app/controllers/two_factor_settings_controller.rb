# frozen_string_literal: true

class TwoFactorSettingsController < ApplicationController
  before_action :authenticate_user!

  def new
    if current_user.otp_required_for_login
      flash[:alert] = '2FA Is enabled.'
      return redirect_to(edit_user_registration_path)
    end

    current_user.skip_password_validation = true
    current_user.generate_two_factor_secret_if_missing!
  end

  def create
    unless current_user.valid_password?(enable_2fa_params[:password])
      flash.now[:alert] = 'Incorrect password'
      return render(:new)
    end

    if current_user.validate_and_consume_otp!(enable_2fa_params[:code])
      current_user.skip_password_validation = true
      current_user.enable_two_factor!

      flash[:notice] = 'Successfully 2FA is enabled. Take note of the backup codes.'
      redirect_to(edit_two_factor_settings_path)
    else
      flash.now[:alert] = 'Incorrect Code'
      render(:new)
    end
  end

  def edit
    unless current_user.otp_required_for_login
      flash[:alert] = 'Enable 2FA first.'
      return redirect_to(new_two_factor_settings_path)
    end

    if current_user.two_factor_backup_codes_generated?
      flash[:alert] = 'You already have seen your backup code.'
      return redirect_to(edit_user_registration_path)
    end

    @backup_codes = current_user.generate_otp_backup_codes!
    current_user.skip_password_validation = true
    current_user.save!
  end

  def destroy
    current_user.skip_password_validation = true
    if current_user.disable_two_factor!
      flash[:notice] = '2FA disabled.'
      redirect_to(edit_user_registration_path)
    else
      flash[:alert] = 'Can`t disabled 2FA.'
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def enable_2fa_params
    params.require(:two_fa).permit(:code, :password)
  end
end
