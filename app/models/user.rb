class User < ApplicationRecord
  has_one :cart

  has_many :orders
  has_many :products
  has_many :reviews

  has_one_attached :avatar

  after_create :assign_cart

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  def assign_cart
    Cart.create(user_id: id)
  end
end
