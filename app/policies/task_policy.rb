class TaskPolicy < ApplicationPolicy

  def index?
  end

  def new?
    @user.admin?
  end

  def create?
    @user.admin?
  end

  def assign?
    @user.admin?
  end

  def destroy?
    @user.admin?
  end

end
