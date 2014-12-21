TwitterCloneRails::Application.routes.draw do
  root to: 'users#index'

  get 'register', to: 'users#new', as: 'register'
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  get '/:username', to: 'users#show', as: 'user'
  get '/', to: 'users#index', as: 'users'

  resources :users, only: [:create]
  resources :statuses, only: [:new, :create, :show]
end
