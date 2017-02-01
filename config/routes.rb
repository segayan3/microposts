Rails.application.routes.draw do

  root to: 'static_pages#home'
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :relationships, only: [:create, :destroy]
  
  resources :users do
    member do
      get :followings, :followers, :favorites
    end
  end

  resources :microposts do
    member do
      post 'reTweet'
      # post 'like', to: 'favorites#create'
      # get 'favorites', to: 'favorites#favorites'
    end
    resource :favorites, only: [:create, :destroy]
  end
end
