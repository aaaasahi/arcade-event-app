Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get 'search', to: 'posts#search'
  resources :events
end
