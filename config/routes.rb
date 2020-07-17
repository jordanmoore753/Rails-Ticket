Rails.application.routes.draw do
  resources :projects
  resources :tickets do
    resources :comments, only: [:edit, :create, :destroy, :update]
  end

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
  get '/tags/:id/edit',    to: 'tags#edit' ,   as: 'edit_tag'
  post '/tags',       to: 'tags#create',  as: 'create_tag'
  patch '/tags/:id',  to: 'tags#update',  as: 'update_tag'
  delete '/tags/:id', to: 'tags#destroy', as: 'destroy_tag'
end
