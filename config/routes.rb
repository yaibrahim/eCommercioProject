Rails.application.routes.draw do
  root to: 'products#index'

  resources :orders do
    get :detail, on: :collection
  end

  resources :reviews, only: [:index]
  resources :order_items
  resources :carts, path: :cart, only: [:index, :new]

  resources :cart_items, only: [:create, :new, :show, :destroy]

  resources :home, only: [:index]

  resources :products do
    collection do
      get :list
      get :search
    end
  end

  resources :products do
    resources :reviews, except: [:show]
  end

  devise_for :users
end
