class CartItem < ApplicationRecord
  # belongs_to :cart, optional: true
  belongs_to :cart
  belongs_to :product

  scope :user_cart, ->(cart_id) { where(cart_id: cart_id) }

  scope :delete_user_cart, ->(cart_id) { where(cart_id: cart_id).delete_all }

  scope :item_existence, ->(product_id) { where(product_id: product_id).exists? }

  scope :get_existed_product_quantity, ->(product_id) { where(product_id: product_id).exists? }

  scope :find_product, ->(product_id) { find_by(product_id: product_id) }

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
end
