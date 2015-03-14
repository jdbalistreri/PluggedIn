Rails.application.routes.draw do
  resources :users, only: [:create, :new]
  resource :session, only: [:create, :destroy, :new]

  namespace :api, defaults: {format: :json} do
    resources :users, only: [:show, :index, :update] do
      resources :connected_users, only: :index
    end

    resources :connections, only: [:create, :update]
    resources :experiences, only: [:create, :update, :destroy, :show]
    get "/search", to: "static#search"
  end

  root "static#root"
end
