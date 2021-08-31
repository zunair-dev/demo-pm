class ApplicationController < ActionController::Base

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

end
