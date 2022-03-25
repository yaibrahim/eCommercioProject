Rails.application.routes.draw do
  resources :reviews, only: [:index, :new, :create, :edit, :update, :show, :destory]
  get 'carts/index'
  get 'cart_items/index'
  devise_for :users
  get 'home/index'
  root to: "home#index"

  resources :products do
    collection do
      get :list
    end
  end

  resources :products do
    resources :reviews
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
