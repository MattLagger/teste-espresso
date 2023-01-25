require 'rails_helper'

RSpec.describe('Login::UserLogins', type: :feature) do
  it 'User login without 2FA' do
    user = create(:user)
    visit '/users/sign_in'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    find_button('Login').click

    expect(page).to(have_current_path(root_path, ignore_query: true))
    expect(page).to(have_content('Signed in successfully.'))
  end
end
