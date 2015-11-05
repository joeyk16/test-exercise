Rails.application.routes.draw do

  resources :categories

  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'

  resources :users do
      resources :outfits do
        get 'add_products'  => 'products#add_outfit_products'
        get 'add_similar_products'  => 'products#add_outfit_similar_products'
        post 'outfit_products'  => 'outfit_products#create'
      end

      get 'users_outfit_products'  => 'outfit_products#users_outfit_products'
      delete 'outfit_products'  => 'outfit_products#destroy'
      get 'approve_outfit_products' => 'outfit_products#approve'
      get 'decline_outfit_products' => 'outfit_products#decline'
    end

  get 'outfits'  => 'outfits#outfits'
  get 'user_products'  => 'users#show_user_products'
  root 'products#home'
  get 'signup'  => 'users#new'
  get 'show'  => 'users#show'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]

  resources :products
  get 'products_new' => 'products#new'

  resources :sizes

  get 'tags/:tag', to: 'categories#show', as: :tag





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
