class UserPolicy < ApplicationPolicy

  def index?
    @user.admin?
  end

  def admins?
    @user.admin?
  end

  def new?
    @user.admin?
  end

  def create?
    @user.admin?
  end

  def show?
    @user.admin?
  end

  def edit?
    @user.admin?
  end

  def update?
    true
  end

  def destroy?
    @user.admin?
  end

  def profile?
    true
  end

  def tasks?
    @user.admin?
  end

  def projects?
    @user.admin?
  end

  def logs?
    true
  end
  
end
