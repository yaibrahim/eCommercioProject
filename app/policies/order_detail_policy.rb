class OrderDetailPolicy < ApplicationPolicy
  def index?
    @user.id == @record.user_id
  end
end
