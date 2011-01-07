class DashboardsController < ApplicationController
  def index
    @user = User.find(2)
    @active_projects = %w()
    @user.roles.each do |r|
      @active_projects << r.project
    end
    @following_projects = %w()
    @user.followers.each do |f|
      @following_projects << f.project
    end
  end
end
