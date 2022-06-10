class OrderPolicy < ApplicationPolicy

  def index?
    true
  end

  def detail?
    authorize_user_id?
  end

  private

  def authorize_user_id?
    @user.id == @record.user_id
  end
end
