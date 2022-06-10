class ProductPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def edit?
    authorize_user_id?
  end

  def update?
    authorize_user_id?
  end

  private

  def authorize_user_id?
    @user.id == @record.user_id
  end
end
