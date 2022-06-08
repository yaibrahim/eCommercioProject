class Product < ApplicationRecord
  DESCRIPTION_SIZE = '60x10'.freeze # this is more related to views so we can keep this in view helpers

  include ProductsHelper # should never include view helper in model.

  belongs_to :user

  # has many orders is missing maybe.
  has_many :order_items
  has_many :reviews

  has_one_attached :pimage

  delegate :full_name, to: :user

  scope :with_name_like, ->(_keyword) { where("name LIKE ?","%" + params[:search] + "%") }

  validates :name, :description, :price, presence: { message: 'can\'t be blank' }
  validates :description, length: { maximum: 300, too_long: '`%<count>s` characters is the maximum allowed' }
  validates :name, length: { minimum: 10, maximum: 50, message: 'length must be 10-50 characters'  }
  validates :user_id, presence: { message: 'user must be present' }
  validates :price, numericality: { only_integer: true, message: 'must be integer value (without decimal) not this `%<value>s`' }

  # try to implement custom validation i.e VALIDATE.

  before_create :add_serial_number # set serial number is a better name

  def add_serial_number
    self.serial_number = serial_number_generator.upcase
  end

  def owner?(cuser_id)
    user_id == cuser_id
  end
end
