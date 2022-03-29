class CartItem < ApplicationRecord
  # belongs_to :cart, optional: true
  belongs_to :cart
  belongs_to :product
end
