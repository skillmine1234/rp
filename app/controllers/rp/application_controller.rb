module Rp
  class ApplicationController < ::ApplicationController
    include Pundit
    protect_from_forgery
        
    before_action :authenticate_user!
    before_action :block_inactive_user!
    
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end
  end
end
