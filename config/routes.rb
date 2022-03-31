Rails.application.routes.draw do
  get 'orders/index'
  get 'order_items/index'
  root to: 'products#index'

  resources :reviews do
    collection do
      get :list
    end
  end

  resources :carts
  resources :cart_items, only: [:create, :new, :show, :destroy] do
    collection do
      post :add_quantity
      post :decrease_quantity
    end
  end

  resources :home, only: [:index]

  resources :products do
    collection do
      get :list
      get :search
    end
  end

  resources :products do
    resources :reviews
  end

  devise_for :users
end
