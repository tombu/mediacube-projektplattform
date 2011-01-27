class DashboardsController < ApplicationController
  def index
    @statusupdates = Statusupdate.joins(:project => {:roles => :user}).where(:users => {:id => current_user.id}).order('created_at DESC').paginate(:page => params[:page], :per_page => 20)
    
    @notifications = Notification.where(:receiver_id => current_user.id).order('created_at DESC')
  end
end
