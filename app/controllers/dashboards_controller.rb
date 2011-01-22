class DashboardsController < ApplicationController
  def index
    @user = User.find(2)
    
    @active_projects = Array.new
    @user.roles.each do |r|
        @active_projects << r.project
    end
    
    @following_projects = Array.new
    @user.followers.each do |f|
      @following_projects << f.project
    end
  end
end
