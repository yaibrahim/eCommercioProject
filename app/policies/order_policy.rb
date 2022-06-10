class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

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
