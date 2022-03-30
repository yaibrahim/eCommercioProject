class Cart < ApplicationRecord
  belongs_to :user

  has_many :cart_items
  has_many :products

  scope :get_id, ->(user_id) { where(user_id: user_id) }
end
