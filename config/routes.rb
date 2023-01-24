# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'welcome#index'
  resource :two_factor_settings, except: %i[index show]
  devise_for :users, controllers: {
    sessions: 'sessions',
    registrations: 'user/registrations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
