Rails.application.routes.draw do
  resources :users, only: [:create, :new]
  resource :session, only: [:create, :destroy, :new]


  root "static#root"
end
