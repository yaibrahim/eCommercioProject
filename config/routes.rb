Rails.application.routes.draw do
  resources :reviews do
    collection do
      get :list
    end
  end

  resources :carts

  post 'cart_items/:id/add' => "cart_items#add_quantity", as: "cart_item_add"
  post 'cart_items/:id/reduce' => "cart_items#decrease_quantity", as: "cart_item_decrease"
  post 'cart_items' => "cart_items#create"
  get 'cart_items/new' => "cart_items#new"
  get 'cart_items/:id' => "cart_items#show", as: "cart_item"
  delete 'cart_items/:id' => "cart_items#destroy"

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
