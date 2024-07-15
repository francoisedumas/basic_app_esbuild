# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    unauthenticated { root to: "devise/sessions#new", as: :unauthenticated_root }

    resource :profile, only: [:edit], controller: :profile
    resource :document, only: [:show]
    resource :report, only: [:show]
    resource :contract, only: [:show, :create]
    resources :users, only: [] do
      resources :customer_accounts, only: %i[new create index], module: :users
    end

    authenticate :user, -> (user) { user.admin? } do
      require "sidekiq/web"

      namespace :admin do
        resources :users
      end
      root to: "admin/users#index", as: "admin_authenticated_root"
    end
  end

  root "profile#edit"
  namespace :webhooks do
    resource :dropbox_sign, controller: :dropbox_sign, only: [:create]
  end
end
