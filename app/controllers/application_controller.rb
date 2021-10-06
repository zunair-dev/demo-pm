class ApplicationController < ActionController::Base
  include Pundit

  before_action :set_breadcrumbs

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def add_breadcrumbs(label, path = nil)
    @breadcrumbs << {
      label: label,
      path: path
    }
  end

  def set_breadcrumbs
    @breadcrumbs = []
  end
  
  def after_sign_in_path_for(resource)
    if current_user.admin == false
      employees_index_path
    else 
      root_url
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    root_url
  end
  
  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
