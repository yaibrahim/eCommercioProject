class Cart < ApplicationRecord
  belongs_to :user

  has_many :cart_items
  has_many :products

  scope :get_id, ->(user_id) { where(user_id: user_id) } # get_id is depicting something else but your scope is returning all the carts of a particular user. Please try to come up with better nomenclature AND current_user.carts would work here as well.
end
