Rails.application.routes.draw do
  root to: 'products#index'

  resources :orders

  resources :order_details, only: [:index]
  resources :reviews
  resources :order_items
  resources :cart, only: [:index]

  resources :cart_items, only: [:create, :new, :show, :destroy, :update]

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

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
end
