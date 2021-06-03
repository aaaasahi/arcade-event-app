Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get 'search', to: 'events#search'
  resources :events
end
