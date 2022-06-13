class OrderPolicy < ApplicationPolicy

  def index?
    true
  end

  private

  def authorize_user_id?
    @user.id == @record.user_id
  end
end
