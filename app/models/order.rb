class Order < ApplicationRecord
  belongs_to :user

  has_many :order_items

  # adding key values is better and safer. kal ko agr ap 0 value kisi aur status ko deni pari tou help hogi. I think this will require some discuss with me.
  # enum status: [initiated: 0, processing: 1, accepted: 2, delivered: 3]
  enum status: [:initiated, :processing, :accepted, :delivered]

  before_create :set_status

  def set_status
    # i think it should be set by default in the DB. Not explicitly like this
    self.status = :initiated
  end

  def name # kya wja iski?
    'ORDER'
  end
end
