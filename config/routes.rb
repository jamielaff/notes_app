Rails.application.routes.draw do
  get 'login',      to: 'sessions#new'
  post 'login',     to: 'sessions#create'
  delete 'logout',  to: 'sessions#destroy'

  resources :users
  resources :notes

  root 'notes#index'
end
