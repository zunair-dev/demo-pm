class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    if current_user.admin == true
      stored_location_for(resource) || :root
    else
      stored_location_for(resource) || :root # pending
    end
  end

end
