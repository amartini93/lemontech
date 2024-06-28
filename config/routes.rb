Rails.application.routes.draw do
  devise_for :users
  resources :events
  root to: 'events#index'
end
