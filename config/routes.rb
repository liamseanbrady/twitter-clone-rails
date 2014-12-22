TwitterCloneRails::Application.routes.draw do
  root to: 'users#index'

  get 'register', to: 'users#new', as: 'register'
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  get '/users', to: 'users#index'
  
  resources :users, only: [:create]
  resources :statuses, only: [:new, :create, :show]

  get '/:username', to: 'users#show', as: 'user'
  post '/:username/follow', to: 'users#follow', as: 'follow_user'
end
