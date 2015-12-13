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
  resources :products, only: [:index, :show] do
    member do
      post 'add_to_cart'
    end
  end

  resources :carts, only: [:index] do
    collection do
      post 'checkout'
    end
  end

  resources :orders, only: [:create, :show] do
    member do
      get 'pay_with_credit_card'
    end
  end
end
