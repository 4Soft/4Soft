# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
		if current_user.profileable_type == "Member"
			member_path(current_user)
		elsif current_user.profileable_type == "Admin"
			admin_home_path
		end
	end

	def admin_only
	  unless current_user and current_user.profileable_type == "Admin"
	    flash[:notice] = "Permissão negada"
	    redirect_to new_session_path(:user)
	  end
	end

	def member_only
	  unless current_user and current_user.profileable_type == "Member"
	    flash[:notice] = "Permissão negada"
	    redirect_to new_session_path(:user)
	  end
	end
end
