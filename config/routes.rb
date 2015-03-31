Rails.application.routes.draw do
  root to: 'search_workers#index'

  get '/sign_up',           to: "users#new"
  get '/sign_in',           to: "sessions#new"
  post '/sign_in',          to: "sessions#create"
  get '/sign_out',          to: "sessions#destroy"
  get '/my_skills',         to: "skills#index"
  post '/my_skills/update', to: "skills#update"
  get '/home',              to: "search_workers#index"
  post '/home',             to: "search_workers#search"

  resources :users, only: [:create]
end
