Pushbc::Application.routes.draw do

  root to: 'pages#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :admins, only: [:new, :create]
  resources :bootcamps, only: [:new, :create, :show]
end
