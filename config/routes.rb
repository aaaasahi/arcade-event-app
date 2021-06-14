Rails.application.routes.draw do
  devise_for :users,
    controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  root 'events#index'
  get 'events/search', to: 'events#search'
  
  resources :events do
    resources :comments, only: [:new, :create]

    resource :clip, only: [:show, :create, :destroy]
    resource :join, only: [:show, :create, :destroy]
  end

  resources :accounts, only: [:show]

  resource :profile, only: [:show, :edit, :update]
  resources :clip_events, only: [:index]
  resources :join_events, only: [:index]
end
