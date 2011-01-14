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
  end
end
