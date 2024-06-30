Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:show, :edit, :update]

  resources :events do
    post 'add_user', on: :member
  end

  root to: 'events#index'
end
