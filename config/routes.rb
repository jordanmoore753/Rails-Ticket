Rails.application.routes.draw do
  resources :projects
  resources :tickets
  
  root to: 'projects#index'

  # user routes
  get '/signup',      to: 'users#new'
  post '/signup',     to: 'users#create'

  # session routes
  get '/login',       to: 'sessions#new'
  post '/login',      to: 'sessions#create'
  delete '/logout',   to: 'sessions#destroy'       

  # tag routes
  get '/tags',        to: 'tags#index'
  get '/tags/new',    to: 'tags#new'
  get '/tags/:id',    to: 'tags#edit' 
  post '/tags',       to: 'tags#create'
  patch '/tags/:id',  to: 'tags#update'
  delete '/tags/:id', to: 'tags#destroy'
end
