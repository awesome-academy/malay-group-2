Rails.application.routes.draw do
  root "static_pages#home"
  
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  get "/courses", to: "courses#index"
  post "/courses", to: "courses#create"
  resources :users
  resources :account_activations, only: :edit
  resources :courses do
    resources :reviews
    resources :registers
  end
  resources :password_resets, except: %i(index show destroy)
end
