Rails.application.routes.draw do
  root 'recipes#index'

  devise_for :users, 
              path_names: { sign_in: 'login', sign_out: 'logout'},
              controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  # User with nested resource for recipes
  resources :users do 
    resources :recipes, only: [:show, :index, :new, :edit]
  end
  get 'users/show'
  get 'users/index'

  # Recipe with nested member routes
  resources :recipes do 
    resources :comments, only: [:create, :show, :index]
    member do 
      # Acts as votable
      put "like", to: "recipes#upvote"
      put "dislike", to: "recipes#downvote"

      # Favorite recipes
      put "favorite", to: "recipes#favorite"
      put "unfavorite", to: "recipes#unfavorite"
    end
  end

  # Search
  get 'search/allergens' => "search#allergen_search"
  post 'search/allergens' => "search#allergen_search"

  # Admin namespace
  namespace :admin do 
    resources :recipes, only: [:index]
    #resources :items, only: [:show, :index, :edit, :update, :destroy]
    resources :allergens, except: [:show]
    resources :users do 
      member do 
        get "users", to: "users#index"
        post "toggle", to: "users#toggle"
      end
    end
  end

  # Static routes
  get 'disclaimer' => "static#disclaimer"
  get 'about' => "static#about"
  
end
