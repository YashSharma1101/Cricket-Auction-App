# config/routes.rb

Rails.application.routes.draw do
  
  # namespace :admin do
  #   get 'users/index'
  #   get 'users/show'
  #   get 'users/new'
  #   get 'users/create'
  #   get 'users/edit'
  #   get 'users/update'
  #   get 'users/destroy'
  # end
  # namespace :admin do
  #   get 'dashboard/index'
  # end
  root to: "users#index"
  get '/teams_data', to: 'users#teams_data', as: 'teams_data'
  post '/send_mail', to: 'users#send_mail', as: 'send_mail'

  resource :admin_sessions, only: [:new, :create, :destroy]
  # namespace :admin do
  #   get 'dashboard', to: 'dashboard#index', as: 'dashboard'
  #   resources :users do
  #     member do
  #       patch :update_full_name
  #     end
  #   end
  # end
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
    }
    member { patch :associate_photo }
  end
end
