class CartItem < ApplicationRecord
  # belongs_to :cart, optional: true
  belongs_to :cart
  belongs_to :product

  # arrange scopes in alphabetical ordern and there's no need to add blank line between two scopes
  scope :user_cart, ->(cart_id) { where(cart_id: cart_id) }
  scope :delete_user_cart, ->(cart_id) { where(cart_id: cart_id).delete_all } # look into delete vs destroy. delete is not appropriate to use here.
  scope :find_product, ->(product_id) { find_by(product_id: product_id) }

  # both following scopes are same with different names.
  scope :item_existence, ->(product_id) { where(product_id: product_id).exists? }
  scope :get_existed_product_quantity, ->(product_id) { where(product_id: product_id).exists? }

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
end
