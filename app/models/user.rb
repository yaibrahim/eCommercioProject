class User < ApplicationRecord
  has_one :cart

  has_many :products
  has_many :reviews
  has_many :orders

  has_one_attached :avatar

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def user_name
    user.full_name
  end

end
