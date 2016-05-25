Rails.application.routes.draw do
  devise_for :users

  resources :users do
    resources :orders, except: [:new, :destroy] do
      get 'ship' => 'orders#ship!', as: :ship
      get 'cancel' => 'orders#cancel!', as: :cancel
      get 'complete' => 'orders#complete!', as: :complete
    end
    resources :cart_items, only: [:create, :index, :destroy]
  end
  root 'products#home'
  resources :paypal_notifications, only: [:create]
end
