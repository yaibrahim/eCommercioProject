class CartItemPolicy < ApplicationPolicy

  def create?
    @user.id != @record.product.user_id
  end
end
