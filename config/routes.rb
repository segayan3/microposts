Rails.application.routes.draw do

  root to: 'static_pages#home'
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :users, :microposts
  resources :relationships, only: [:create, :destroy]
  
  resources :users do
    member do
      get 'followings'
    end
  end
  
  resources :users do
    member do
      get 'followers'
    end
  end
  
  resources :microposts do
    member do
      post 'reTweet'
    end
  end
  
  resources :microposts do
    member do
      post 'like', to: 'favorites#create'
      get 'favorites', to: 'favorites#favorites'
    end
  end
end
