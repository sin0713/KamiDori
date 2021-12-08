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

  resources :recipes, only: [:new, :create, :edit, :update, :show, :destroy] do
    resource :favorites, only: [:create, :destroy, :index]
    collection do 
      get :favorites
    end
    resources :recipe_comments, only: [:create, :destroy]
    collection do
      get :search
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
