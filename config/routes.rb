Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post '/graphql',  to: 'graphql#execute'
  
  namespace api do
    namespace v1 do:
      get 'login',      to: 'sessions#new'
      post 'login',     to: 'sessions#create'
      delete 'logout',  to: 'sessions#destroy'
      get 'signup',     to: 'users#new'

      resources :users
      resources :notes, except: [:index] do
        collection do
          get :pending
        end
        put :approve
      end
    end
  end

  root 'notes#index'
end
