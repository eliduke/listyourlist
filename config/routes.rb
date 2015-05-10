Rails.application.routes.draw do

  root 'home#index'

  resources :lists

  get 'about', to: 'home#about', as: :about

  get 'users', to: 'users#index', as: :users
  get 'users/seed', to: 'users#seed', as: :user_seed

  get '@:login', to: 'users#show', as: :profile, username: /[^\/]+/
  get "/:login", to: redirect { |params, request| "/@#{params[:login]}"}

end
