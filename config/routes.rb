Rails.application.routes.draw do
  devise_for :users
  root 'events#index'
  get 'events/search', to: 'events#search'
  get '/users/:id', to: 'users#show', as: 'user'
  
  resources :events
end
