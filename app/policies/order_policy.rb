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
    @user.id == @record.user_id
  end
end
