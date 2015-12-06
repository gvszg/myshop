Rails.application.routes.draw do
  devise_for :users
  #mockup
  get 'ui(/:action)', controller: 'ui'

  # admin products
  namespace :admin do
    resources :products
  end
end
