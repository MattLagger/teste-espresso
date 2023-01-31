# frozen_string_literal: true

require 'rails_helper'

RSpec.describe('Otps::UserDisables', type: :feature) do
  it 'disables otp for user' do
    user = create(:user, :with_otp)
    login_as(user)

    visit edit_user_registration_path

    expect(page).to(have_content('Two factor authentication is enabled.'))
    expect(page).to(have_link('Disable Two Factor Authentication'))

    click_link('Disable Two Factor Authentication')
    page.accept_alert('Are you sure you want to disable two factor authentication?')

    expect(page).to(have_content('Two factor authentication is NOT enabled.'))
    expect(page).to(have_link('Enable Two Factor Authentication'))
  end
end
