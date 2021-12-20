Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  root to: 'homes#top'
  get '/about' => 'homes#about'

  resources :users, only: [:edit, :show, :update, :destroy] do
    resource :relationships, only: [:create, :destroy]
    member do
      get :followings
      get :followers
      get :confirmation
    end
  end

  resources :recipes, only: [:new, :create, :edit, :update, :show, :destroy] do
    resource :favorites, only: [:create, :destroy, :index]
    collection do
      get :favorites
      get :search
      get :ranking
      get :new_order
    end
    resources :recipe_comments, only: [:create, :destroy]
  end

  resource :contacts, only: [:new, :create] do
    collection do
      get :confirm
      post :back
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
