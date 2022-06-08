class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  # I think this would work too
  # delegate :name, :price, to: :product, prefix: true


  delegate :name, to: :product, prefix: true
  delegate :price, to: :product, prefix: true
end
