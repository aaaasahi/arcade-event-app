Rails.application.routes.draw do
  devise_for :users,
    controllers: { registrations: 'registrations' }
  root 'events#index'
  get 'events/search', to: 'events#search'
  get '/users/:id', to: 'users#show', as: 'user'
  
  resources :events

  resource :profile, only: [:show, :edit, :update]
end
