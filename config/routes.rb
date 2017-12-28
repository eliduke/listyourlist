Rails.application.routes.draw do

  root 'home#index'

  resources :lists, only: [:index, :show]
  resources :users, only: [:show]

  get 'about', to: 'home#about', as: :about

  namespace :admin do
    get 'dashboard', to: 'admin#dashboard', as: :dashboard
    get 'seed', to: 'admin#seed', as: :seed

    resources :lists, except: [:show]
    resources :users, only: [:new, :create, :edit, :update]
  end

  get '@:username', to: 'users#show', as: :profile, username: /[^\/]+/
  get "/:username", to: redirect { |params, request| "/@#{params[:username]}" }

  get 'admin/login' => 'admin/sessions#new', as: :login
  post 'admin/login' => 'admin/sessions#create'
  get 'admin/logout' => 'admin/sessions#destroy', as: :logout
end
