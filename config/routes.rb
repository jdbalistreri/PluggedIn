Rails.application.routes.draw do
  resources :users, only: [:create, :new]
  resource :session, only: [:create, :destroy, :new]

  get "session/demo", to: "users#new_demo"
  get "demo", to: "users#new_demo"
  get "auth/:provider/callback", to: "sessions#omniauth"


  namespace :api, defaults: {format: :json} do
    resources :users, only: [:show, :update]

    resources :connections, only: [:create, :update]
    resources :messages, only: [:create, :show]

    get "/inbox", to: "inbox#index"
    get "/inbox/connected_users", to: "inbox#connected_users"

    resources :experiences, only: [:create, :update, :destroy, :show]

    get "/search", to: "static#search"
    get "/connections_search", to: "static#connections_search"
  end

  root "static#root"
end
