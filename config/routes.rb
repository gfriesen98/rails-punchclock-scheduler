Rails.application.routes.draw do
  resources :punchies
  resources :shifts
  # root 'welcome#index'
  root 'sessions#new'

  resources :users
  resources :welcome, only: [:new, :create, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'punchclock', to: 'punchies#index', as: 'punchclock'
  get 'punchout', to: 'punchies#update', as: 'punchout'
end
