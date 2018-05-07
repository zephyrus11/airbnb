require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'


  resources :listings do
    resources :reservations
  end

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: [:create, :edit, :update] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  get "/users/edit" => "users#edit", as: "edit"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post "/users/edit" => "users#update", as: "update"
  root to: "home#home"
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  get "/listings/:id/reservations/new" => "reservations#new", as: "reservations_new"
  post "/listings/:id/reservations/new" => "reservations#create"
  
  get 'braintree/new/:id' => "braintree#new"
  post 'braintree/checkout'
end
