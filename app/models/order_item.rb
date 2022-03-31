class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  delegate :name, to: :product, prefix: true
  delegate :price, to: :product, prefix: true
end
