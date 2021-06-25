Rails.application.routes.draw do
  devise_for :users,
    controllers: { 
      registrations: 'users/registrations',
      passwords: "users/passwords"
    }
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  namespace :administrator do
    resources :admins, only: [:index]
    resources :events_data, only: [:index]
    resources :users_data, only: [:index]
  end

  root 'events#index'
  scope "(:locale)" do
    get 'events/search', to: 'events#search'
  end
  get 'events/search/sort_new', to: 'events#search', as: 'sort_new'
  get 'events/search/sort_old', to: 'events#search', as: 'sort_old'
  get 'events/search/sort_join', to: 'events#search', as: 'sort_join'
  
  resources :events do
    resources :comments, only: [:new, :create]

    resource :clip, only: [:show, :create, :destroy]
    resource :join, only: [:show, :create, :destroy]
  end

  resources :accounts, only: [:show]
  get '/accounts/:id/unsubscribe' => 'accounts#unsubscribe', as: 'unsubscribe'
  patch '/accounts/:id/withdrawal' => 'accounts#withdrawal', as: 'withdrawal'

  resource :profile, only: [:show, :edit, :update]

  resources :clip_events, only: [:index]
  resources :join_events, only: [:index]
  resources :calendars, only: [:index]
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :index, :show]
end
