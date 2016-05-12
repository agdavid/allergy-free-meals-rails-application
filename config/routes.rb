Rails.application.routes.draw do
  
  root 'recipes#index'

  devise_for :users, 
              path_names: { sign_in: 'login', sign_out: 'logout'},
              controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  

  # User with nested resource for recipes
  get 'users/show'
  get 'users/index'
  resources :users do 
    resources :recipes, only: [:show, :index, :new, :edit]
  end

  # Recipe with nested member routes
  resources :recipes do 
    member do 
      # Acts as votable
      put "like", to: "recipes#upvote"
      put "dislike", to: "recipes#downvote"

      # Favorite recipes
      put "favorite", to: "recipes#favorite"
      put "unfavorite", to: "recipes#unfavorite"
    end
  end
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
