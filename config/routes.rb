Rails.application.routes.draw do
  devise_for :users

  resources :categories

  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'

  resources :users do
    resources :outfits do
      get 'add_products'  => 'outfit_products#add_outfit_products'
      post 'outfit_products'  => 'outfit_products#create'
      get 'outfit_products'  => 'outfit_products#outfit_products'
    end
    resources :addresses
    resources :shipping_methods, only: [:new, :create, :edit, :update, :destroy]
    resources :carts, only: [:create, :index, :show, :destroy]
    get 'users_outfit_products'  => 'outfit_products#users_outfit_products'
    delete 'outfit_products'  => 'outfit_products#destroy'
    get 'approve_outfit_products' => 'outfit_products#approve'
    get 'decline_outfit_products' => 'outfit_products#decline'
    get 'my_account' => 'users#my_account'
    get 'destroy_avatar' => 'users#destroy_avatar'
    get 'destroy_header_image' => 'users#destroy_header_image'
  end

  get 'outfits'  => 'outfits#outfits'
  get 'user_products'  => 'users#show_user_products'
  root 'products#home'
  get 'signup'  => 'users#new'
  get 'show'  => 'users#show'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  resources :product_images, only: [:destroy]

  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :product_sizes, only: [:create]

  resources :products do
    resources :photos
  end

  get 'products_new' => 'products#new'

  resources :sizes

  get 'tags/:tag', to: 'categories#show', as: :tag
end
