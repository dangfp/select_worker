Rails.application.routes.draw do
  root to: 'users#new'

  get '/sign_in', to: 'sessions#new'

  resources :users, only: [:new, :create]
end
