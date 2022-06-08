class CartItem < ApplicationRecord
  # belongs_to :cart, optional: true
  belongs_to :cart
  belongs_to :product


  scope :delete_user_cart, ->(cart_id) { where(cart_id: cart_id).delete_all }
  scope :find_product, ->(cart_id, product_id) { CartItem.find_by!(cart_id: cart_id, product_id: product_id) }
  scope :get_existed_product_quantity, ->(product_id) { where(product_id: product_id).exists? }
  scope :user_cart, ->(cart_id) { where(cart_id: cart_id) }

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  def self.product_exists?(cart_id, product_id)
    exists?(cart_id: cart_id, product_id: product_id)
  end
end
