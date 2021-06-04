Rails.application.routes.draw do
  devise_for :users
  root 'events#index'
  get 'events/search', to: 'events#search'
  resources :events
end
