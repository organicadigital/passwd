Rails.application.routes.draw do
  devise_for :users

  root to: 'wallets#index'

  resources :wallets
end
