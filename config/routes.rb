Rails.application.routes.draw do
  root 'home#index'

  controller :home do
    get :about
    get :dashboard
    get :seed
  end

  resources :lists, except: [:index]

  controller :users do
    get :signup, action: :new, as: :signup
    post :signup, action: :create

    get :settings, action: :edit
    patch :settings, action: :update

    get "settings/change_password", action: :change_password
    patch "settings/change_password", action: :update_password
  end

  controller :sessions do
    get :login, action: :new, as: :login
    post :login, action: :create
    delete :logout, action: :destroy, as: :logout
  end

  get '@:username', to: 'users#show', as: :profile, username: /[^\/]+/
  get "/:username", to: redirect { |params, request| "/@#{params[:username]}" }
end
