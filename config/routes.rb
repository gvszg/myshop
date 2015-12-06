Rails.application.routes.draw do
  #mockup
  get 'ui(/:action)', controller: 'ui'

  # admin products
  namespace :admin do
    resources :products
  end
end
