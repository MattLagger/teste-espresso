# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(User, type: :model) do
  context 'User register validation' do
    it 'user password is valid' do
      user = create(:user)
      expect(user).to(be_valid)
    end

    it 'user email is invalid' do
      user = build(:user, :invalid_email)
      expect(user).not_to(be_valid)
    end

    it 'user password is missing uppercase' do
      user = build(:user, :password_missing_uppercase)
      user.validate
      expect(user.errors.messages[:password][0]).to(eq(' must contain at least one uppercase letter'))
    end

    it 'user password is missing lowercase' do
      user = build(:user, :password_missing_lowercase)
      user.validate
      expect(user.errors.messages[:password][0]).to(eq(' must contain at least one lowercase letter'))
    end
  end

  context 'User two factor test' do
    before { @user = create(:user) }

    it 'generates new 2FA secret' do
      @user.generate_two_factor_secret_if_missing!
      expect(@user.otp_secret?).to(be(true))
    end

    it 'enable 2FA' do
      @user.enable_two_factor!
      expect(@user.otp_required_for_login).to(be(true))
    end

    it '2FA qr_code_uri' do
      qr_code_uri = @user.two_factor_qr_code_uri
      expect(qr_code_uri.present?).to(eq(true))
    end

    it 'generate backup codes' do
      @user.generate_otp_backup_codes!
      expect(@user.two_factor_backup_codes_generated?).to(be(true))
    end

    it 'disable 2FA secret' do
      @user.disable_two_factor!
      expect(@user.otp_secret?).to(be(false))
    end
  end
end
