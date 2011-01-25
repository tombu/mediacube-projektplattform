class NotificationsController < ApplicationController
  def index
  end

  def destroy
    Notification.find(params[:id]).destroy    
    respond_to do |format|
      format.js { render :nothing => true }
    end
  end
end