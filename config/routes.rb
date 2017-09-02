Rails.application.routes.draw do
  root 'pages#home'

  resources :reservations
  resources :pets
  resources :users
end
