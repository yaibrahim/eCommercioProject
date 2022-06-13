class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user

  delegate :full_name, to: :user

  delegate :name, to: :product, prefix: true

  def owner?(cuser_id)
    user_id == cuser_id
  end
end
