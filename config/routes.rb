# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    unauthenticated { root to: "devise/sessions#new", as: :unauthenticated_root }

    resource :profile, only: [:edit, :update], controller: :profile

    authenticate :user, -> (user) { user.admin? } do
      require "sidekiq/web"

      namespace :admin do
        resources :users
      end
      root to: "admin/users#index", as: "admin_authenticated_root"
    end
  end

  root "profile#edit"
end
