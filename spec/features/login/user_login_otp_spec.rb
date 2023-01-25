require 'rails_helper'

RSpec.describe('Login::UserLoginOtps', type: :feature) do
  it 'invalid user' do
    visit root_path
    fill_in 'Email', with: 'someone@example.com'
    fill_in 'Password', with: 'letmein'
    click_button 'Login'

    expect(page).to(have_content('Invalid Email or password.'))
  end

  it 'login with invalid otp' do
    user = create(:user, :with_otp)

    visit root_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Login'

    fill_in 'OTP', with: 'invalid-otp'
    click_button 'Login'

    expect(page).to(have_content('Invalid two-factor code.'))
  end

  it 'login with valid otp' do
    user = create(:user, :with_otp)

    visit root_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    find_button('Login').click

    fill_in 'OTP', with: user.current_otp
    find_button('Login').click

    expect(page).to(have_current_path(root_path, ignore_query: true))
    expect(page).to(have_content('Signed in successfully.'))
  end
end
