Rails.application.routes.draw do
  root to: 'products#index'

  # i think some of the routes can be removed and functionality can be implemented in a more simpler way.

  resources :orders do
    collection do
      get :detail # for this, we could have made an order_items_controller having #index action. that's how we keep controllers THIN.
    end
  end

  resources :reviews do
    collection do
      get :list # no need for this. we can manage this with #index
    end
  end

  resources :order_items
  resources :carts # carts should be cart and this should be 'resource' route. not resources

  resources :cart_items, only: [:create, :new, :show, :destroy] do
    collection do
      post :add_quantity
      post :decrease_quantity # decrease is more of a technical term. I think reduce_quantity is more appropriate
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
    resources :reviews # i think there's no need to have #show
  end

  devise_for :users
end
