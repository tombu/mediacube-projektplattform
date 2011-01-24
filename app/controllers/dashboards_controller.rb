class DashboardsController < ApplicationController
  def index
    @active_projects = %w()
    current_user.is_involved.each do |r|
        @active_projects << r.project
    end
    @following_projects = %w()
    current_user.is_following.each do |f|
      @following_projects << f.project
    end
    
    @statusupdates = Statusupdate.joins(:project => {:roles => :user}).where(:users => {:id => current_user.id}).order('created_at DESC')
    
    @notifications = Notification.where(:receiver_id => current_user.id).order('created_at DESC')
  end
end
