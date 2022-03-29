class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user

  delegate :full_name, to: :user

  scope :all_reviews, ->(user_id) { where(user_id: user_id) }

  delegate :name, to: :product, prefix: true

  delegate :full_name, to: :user, prefix: true

  def name
    'review'
  end

  def owner?(cuser_id)
    user_id == cuser_id
  end
end
