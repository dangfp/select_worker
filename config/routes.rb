Rails.application.routes.draw do
  root to: 'users#new'

  get '/sign_in',           to: 'sessions#new'
  get '/my_skills',         to: "skills#index"
  post '/my_skills/update', to: "skills#update"
  get '/home',              to: "search_workers#index"
  post '/home',             to: "search_workers#search"

  resources :users, only: [:new, :create]
end
