Rails.application.routes.draw do
  root 'pages#home'

  resources :reservations
  resources :pets
  resources :users

  get 'signup', to: 'users#new'
  resources :users, except: [:new]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
