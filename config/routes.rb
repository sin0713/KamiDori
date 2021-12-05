Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get '/about' => 'homes#about'
  
  resources :users, only: [:edit, :show, :update] do
    resource :relationships, only: [:create, :destroy]
    member do
      get :followings
      get :followers
    end 
  end
  
  resources :recipes, only: [:new, :create, :edit, :update, :show, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
    get '/search' => 'recipes#search'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
