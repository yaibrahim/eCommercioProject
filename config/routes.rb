Rails.application.routes.draw do
  get 'reviews/index'
  get 'reviews/new'
  get 'reviews/show'
  get 'reviews/edit'
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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
