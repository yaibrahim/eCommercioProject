class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user

  delegate :full_name, to: :user

  scope :all_reviews, ->(user_id) { where(user_id: user_id) } # not needed. current_user.reviews is more than enough

  delegate :name, to: :product, prefix: true

  delegate :full_name, to: :user, prefix: true


  # 1. saray delegate ek sath kuen nai hain????
  # 2. duplicate delegate kuen hain??

  def name # purpose of this??? if this for views only then we can put this in helpers. but it seems useless to me.
    'review'
  end

  def owner?(cuser_id)
    user_id == cuser_id
  end
end
