class Order < ApplicationRecord
  has_many :order_items

  belongs_to :user

  enum status: [:initiated, :processing, :accepted, :delivered]

  before_create :set_status

  def set_status
    self.status = :initiated
  end

end
