# config/routes.rb

Rails.application.routes.draw do
  
  get 'teams/index'
  get 'teams/create'
  get 'teams/update'
  get 'teams/destory'

  root to: "users#home"
  get '/teams_data', to: 'users#teams_data', as: 'teams_data'
  post '/send_mail', to: 'users#send_mail', as: 'send_mail'

  resources :admin_sessions do
    delete '/delete_admin', to: 'admin_sessions#delete_admin', as: 'delete_admin'
  end #, only: [:new, :create, :destroy]
  
  namespace :admin do
    get 'dashboard', to: 'dashboard#index', as: 'dashboard'
    get 'search', to: 'users#search', as: 'search'
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
    }
    member { patch :associate_photo }
  end
  resources :teams
  resources :admin 

end
