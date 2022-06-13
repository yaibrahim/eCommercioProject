class ProductPolicy < ApplicationPolicy

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
