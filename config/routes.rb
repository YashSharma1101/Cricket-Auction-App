# config/routes.rb

Rails.application.routes.draw do
  
  # get 'matches/index'
  # get 'matches/create'
  # get 'matches/show'
  # get 'matches/update'
  # get 'matches/delete'
  # get 'teams/index'
  # get 'teams/create'
  # get 'teams/update'
  # get 'teams/destory'
  resources :matches

  root to: "users#home"
  get '/teams_data', to: 'users#teams_data', as: 'teams_data'

  resources :admin_sessions do
    delete '/delete_admin', to: 'admin_sessions#delete_admin', as: 'delete_admin'
    collection do
      patch 'reset_all_data;', to: 'admin_sessions#reset_all_data'
    end
  end #, only: [:new, :create, :destroy]
  
  namespace :admin do
    get 'dashboard', to: 'dashboard#index', as: 'dashboard'
    get 'search', to: 'users#search', as: 'search'
    post 'view_access_form', to: 'users#access_form', as: 'access_form'
    get 'view_access_form', to: 'users#view_access_form', as: 'view_access_form'
    # resources :access_forms
    resources :users do
      member do
        patch :update_full_name
        patch :update_email
        patch :update_skill
        patch :update_level
      end
    end
  end
  resources :users do
    collection { 
      post :import
      get :associate_photos 
      get 'home', to: 'users#home'
      get 'unsold', to: 'users#unsold'
      get 'send_mail', to: 'users#send_mail', as: 'send_mail'
    }
    member { 
      patch :associate_photo
      patch 'reset_data', to: 'users#reset_data'
      post 'player_mail', to: 'users#player_mail', as: 'player_mail'
    }
  end
  resources :teams
  resources :admin 

end
