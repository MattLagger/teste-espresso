# frozen_string_literal: true

require 'rails_helper'

RSpec.describe('Register::UserRegisters', type: :feature) do
  context 'create a valid user' do
    it 'creates a new user' do
      user = attributes_for(:user)
      visit '/users/sign_up'

      fill_in 'Email', with: user[:email]
      fill_in 'password', with: user[:password]
      fill_in 'password_confirmation', with: user[:password]

      find_button('Sign up').click

      expect(page).to(have_current_path(root_path, ignore_query: true))
      expect(page).to(have_content('Welcome! You have signed up successfully.'))
    end
  end
end
