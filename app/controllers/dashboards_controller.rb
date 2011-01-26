class DashboardsController < ApplicationController
  def index
    @active_projects = %w()
    current_user.is_involved.each do |r|
        if r.project.status != "finished"
          @active_projects << r.project
        end
    end
    @following_projects = %w()
    current_user.is_following.each do |f|
      @following_projects << f.project
    end
    
    @statusupdates = Statusupdate.joins(:project => {:roles => :user}).where(:users => {:id => current_user.id}).order('created_at DESC').paginate(:page => params[:page], :per_page => 20)
    
    @notifications = Notification.where(:receiver_id => current_user.id).order('created_at DESC')
  end
end
