class Order < ApplicationRecord
  belongs_to :user

  has_many :order_items

  enum status: [initiated: 0, processing: 1, accepted: 2, delivered: 3]

  before_create :set_status

  def set_status
    self.status = 0
  end
end
