Rails.application.routes.draw do
  root 'pages#home'
  get 'about', to: 'pages#about'
  get 'faq', to: 'pages#faq'
  get 'services', to: 'pages#services'

  resources :reservations
  resources :pets
  resources :users
  resources :testimonials
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :account_activations, only: [:new, :create, :edit]
  resources :walking_schedules

  get 'signup', to: 'users#new'
  resources :users, except: [:new]

  get 'contact', to: 'leads#new'
  get 'thank-you', to: 'leads#thank_you'
  resources :leads, only: [:new, :create]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
