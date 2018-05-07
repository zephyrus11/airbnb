class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception

  def allowed?(action:, user:)
   # authorization code
      if user.customer?
        flash[:notice] = "Sorry. You are not allowed to perform this action."
        return redirect_to listings_url, notice: "Sorry. You do not have the permission to verify a property."
      end

    
  end
end
