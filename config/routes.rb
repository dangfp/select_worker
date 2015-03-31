Rails.application.routes.draw do
  root to: 'users#new'

  get '/sign_in', to: 'sessions#new'
  get '/my_skills',  to: "skills#index"
  post '/my_skills/update', to: "skills#update"

  resources :users, only: [:new, :create]
end
