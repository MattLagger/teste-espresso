# frozen_string_literal: true

require 'rails_helper'

RSpec.describe('TwoFactorSettings', type: :request) do
  describe 'GET /new' do
    it 'returns http success' do
      get '/two_factor_settings/new'
      expect(response).to(have_http_status(:success))
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get '/two_factor_settings/edit'
      expect(response).to(have_http_status(:success))
    end
  end
end
