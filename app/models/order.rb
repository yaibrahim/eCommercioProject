class Order < ApplicationRecord
  belongs_to :user

  has_many :order_items

  enum status: { initiated: 0, processing: 1, accepted: 2, delivered: 3 }, _default: :initiated
end
