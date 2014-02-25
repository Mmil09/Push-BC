Pushbc::Application.routes.draw do

  root to: 'pages#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, only: [:new, :create, :edit, :update, :show]
  resources :admins, only: [:new, :create]
  
  resources :bootcamps, only: [:new, :create, :show, :edit, :update] do 
    resources :reviews, only: [:edit, :update, :create, :show]
  end
  
  resources :bc_admins, only: [:new, :create]
end
