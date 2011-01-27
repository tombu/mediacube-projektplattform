# encoding: UTF-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :authenticate_user!
  before_filter { |c| Authorization.current_user = c.current_user }
  before_filter { |c| @notifications = (current_user.nil?) ? Array.new : c.current_user.notifications }
  
  def permission_denied
    flash[:error] = "Achtung, du hast für diese Seite keine Zugriffsrechte."
    redirect_to root_url
  end

end
  
