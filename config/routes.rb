Rails.application.routes.draw do
  root 'products#index'

  # mockup
  get 'ui(/:action)', controller: 'ui'

  # admin products
  namespace :admin do
    resources :products
  end

  # users
  devise_for :users

  # products
  # resources :products, only: [:index]
end
