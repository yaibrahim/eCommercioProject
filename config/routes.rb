Rails.application.routes.draw do
  resources :orders do
    collection do
      get :detail
    end
  end

  root to: 'products#index'

  resources :reviews do
    collection do
      get :list
    end
  end

  resources :order_items
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
