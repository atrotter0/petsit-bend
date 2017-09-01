Rails.application.routes.draw do
  root 'pages#home'

  resources :reservations
  resources :pets
end
