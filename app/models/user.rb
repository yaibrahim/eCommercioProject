class User < ApplicationRecord
  has_one :cart

  has_many :orders
  has_many :products
  has_many :reviews

  has_one_attached :avatar

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  def user_name
    user.full_name # no need for this. we can simply replace full_name field of database into user_name but I don't think this is necessary
  end
end
