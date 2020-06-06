Rails.application.routes.draw do
  get 'login',      to: 'sessions#new'
  post 'login',     to: 'sessions#create'
  delete 'logout',  to: 'sessions#destroy'
  get 'signup',     to: 'users#new'

  resources :users
  resources :notes, except: [:index]

  root 'notes#index'
end
