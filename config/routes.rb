Rails.application.routes.draw do
  devise_for :users,
    controllers: { registrations: 'registrations' }
  root 'events#index'
  get 'events/search', to: 'events#search'
  
  resources :events do
    resources :comments, only: [:new, :create]

    resource :clip, only: [:show, :create, :destroy]
    resource :join, only: [:create, :destroy]
  end

  resources :accounts, only: [:show]

  resource :profile, only: [:show, :edit, :update]
  resources :clip_events, only: [:index]
  resources :join_events, only: [:index]
end
