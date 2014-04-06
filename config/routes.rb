Pushbc::Application.routes.draw do

  root to: 'pages#show', :id => 'home'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :users, only: [:new, :create, :edit, :update, :show]
  resources :admins, only: [:new, :create]
  
  resources :bootcamps, only: [:new, :create, :show, :edit, :update, :index] do 
    resources :reviews, only: [:edit, :update, :create, :show]
  end
  
  resources :bc_admins, only: [:new, :create]
  resources :replies, only: [:create]
  resources :pages
end
