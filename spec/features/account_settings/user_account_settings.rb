require 'rails_helper'

RSpec.describe('AccountSettings::UsserAccountSettings', type: :feature) do
  it 'As a user without OTP, I can enable OTP' do
    user = create(:user)
    login_as(user)

    visit edit_user_registration_path

    expect(page).to(have_content('Two factor authentication is NOT enabled.'))
    expect(page).to(have_link('Enable Two Factor Authentication'))
  end

  it 'As a user with OTP, I can disable OTP' do
    user = create(:user, :with_otp)
    login_as(user)

    visit edit_user_registration_path

    expect(page).to(have_content('Two factor authentication is enabled.'))
    expect(page).to(have_link('Disable Two Factor Authentication'))
  end
end
