Rails.application.routes.draw do
  root 'products#index'

  # mockup
  get 'ui(/:action)', controller: 'ui'

  # admin products
  # admin orders
  # admin order options
  namespace :admin do
    resources :products
    resources :orders do
      member do
        post 'cancel'
        post 'ship'
        post 'shipped'
        post 'return'
      end
    end
  end

  # users
  devise_for :users

  # products
  resources :products, only: [:index, :show] do
    member do
      post 'add_to_cart'
    end
  end

  # carts
  resources :carts, only: [:index] do
    collection do
      post 'checkout'
      delete 'clean'
    end

    resources :items, :controller => "cart_items"
  end

  # orders
  resources :orders, only: [:create, :show] do
    member do
      get 'pay_with_credit_card'
      post 'allpay_notify'
    end
  end

  # account::order
  namespace :account do
    resources :orders, only: [:index]
  end
end
