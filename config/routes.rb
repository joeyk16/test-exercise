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
    resources :relationships, only: [:create, :destroy]
    get 'followers' => 'relationships#followers'
    get 'following' => 'relationships#following'
    resources :addresses, only: [:new, :create, :edit, :update, :destroy]
    resources :paypals, except: [:index]
    resources :orders, except: [:new, :show]
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
  resources :product_sizes, only: [:create]
  resources :sizes
  resources :likes, only: [:create, :destroy]
  resources :paypal_notifications, only: [:create]

  resources :products do
    resources :photos
  end

  get 'products_new' => 'products#new'

  resources :sizes

  get 'tags/:tag', to: 'products#index', as: :tag
  get 'outfit_tags/:tag' => 'outfits#outfits', as: :outfit_tag
end
