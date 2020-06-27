Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post '/graphql',  to: 'graphql#execute'

  namespace :api do
    namespace :v1 do
      resources :users
      resources :notes
    end
  end

  post 'refresh',   controller: :refresh, action: :create
  post 'signin',    controller: :signin,  action: :create
  delete 'signin',  controller: :signin,  action: :destroy
  post 'signup',    controller: :users,   action: :create

  root 'notes#index'
end
