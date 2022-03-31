class Product < ApplicationRecord
  DESCRIPTION_SIZE = '60x10'.freeze

  include ProductsHelper

  belongs_to :user

  has_many :reviews
  has_many :order_items

  has_one_attached :pimage

  delegate :full_name, to: :user

  validates :name, :description, :price, presence: { message: 'can\'t be blank' }
  validates :description, length: { maximum: 300, too_long: '`%<count>s` characters is the maximum allowed' }
  validates :name, length: { minimum: 10, maximum: 50, message: 'length must be 10-50 characters'  }
  validates :user_id, presence: { message: 'user must be present' }
  validates :price, numericality: { only_integer: true, message: 'must be integer value (without decimal) not this `%<value>s`' }

  before_create :add_serial_number

  def add_serial_number
    self.serial_number = serial_number_generator.upcase
  end

  def owner?(cuser_id)
    user_id == cuser_id
  end
end
