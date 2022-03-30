Rails.application.routes.draw do
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

  resources :home, only: [:index] do
    get :search
  end

  resources :products do
    collection do
      get :list
    end
  end

  resources :products do
    resources :reviews
  end

  devise_for :users
end
