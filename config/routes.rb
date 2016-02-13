Rails.application.routes.draw do
  devise_for :users

  root to: 'wallets#index'

  resources :wallets do
    resources :secure_notes, except: [:index, :show]

    resources :members, only: [:new, :create, :destroy]
  end
end
