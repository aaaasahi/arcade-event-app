Rails.application.routes.draw do
  devise_for :users,
    controllers: { registrations: 'registrations' }
  root 'events#index'
  get 'events/search', to: 'events#search'
  get '/users/:id', to: 'users#show', as: 'user'
  
  resources :events do
    resources :comments, only: [:new, :create]

    resource :clip, only: [:create, :destroy]
    resource :join, only: [:create]
  end

  resource :profile, only: [:show, :edit, :update]
  resources :clip_events, only: [:index]
end
