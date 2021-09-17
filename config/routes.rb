Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  devise_for :users,
             controllers: {
               registrations: 'users/registrations',
               passwords: 'users/passwords'
             }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  namespace :administrator do
    resources :admins, only: [:index]
    resources :events_data, only: [:index]
    resources :users_data, only: [:index]
  end

  root 'events#index'

  namespace :guide do
    resources :posts, only: [:index]
    resources :search, only: [:index]
  end

  scope '(:locale)' do
    get 'events/search', to: 'events#search'
  end
  get 'events/search/sort_new', to: 'events#search', as: 'sort_new'
  get 'events/search/sort_old', to: 'events#search', as: 'sort_old'
  get 'events/search/sort_join', to: 'events#search', as: 'sort_join'

  resources :events do
    resources :comments, only: %i[new create]
  end

  namespace :api, defaults: { format: :json } do
    scope '/events/:event_id' do
      resource :clip, only: %i[show create destroy]
      resource :join, only: %i[show create destroy]
    end
  end

  resources :accounts, only: [:show]
  get '/accounts/:id/unsubscribe' => 'accounts#unsubscribe', as: 'unsubscribe'
  patch '/accounts/:id/withdrawal' => 'accounts#withdrawal', as: 'withdrawal'

  resource :profile, only: %i[show edit update]

  resources :clip_events, only: [:index]
  resources :join_events, only: [:index]
  resources :calendars, only: [:index]
  resources :notifications, only: %i[index update]
  resources :messages, only: [:create]
  resources :rooms, only: %i[create index show]
end
