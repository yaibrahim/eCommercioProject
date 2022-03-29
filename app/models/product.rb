class Product < ApplicationRecord
  DESCRIPTION_SIZE = '60x10'.freeze

  include ProductsHelper

  belongs_to :user

  has_many :reviews

  has_one_attached :pimage

  delegate :full_name, to: :user

  validates :name, :description, :price, presence: true
  validates :description, length: { maximum: 30, too_long: '%{count} characters is the maximum allowed' }
  validates :name, length: { minimum: 10, maximum: 50 }
  validates :user_id, presence: true
  validates :price, numericality: { only_integer: true }

  before_create :add_serial_number

  def add_serial_number
    self.serial_number = serial_number_generator.upcase
  end

  def owner?(cuser_id)
    user_id == cuser_id
  end
end
