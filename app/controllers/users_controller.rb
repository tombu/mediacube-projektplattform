class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
    @active_projects = %w()
    @user.roles.each do |r|
      @active_projects << r.project
    end
    @following_projects = %w()
    @user.followers.each do |f|
      @following_projects << f.project
    end
    
    @portfolio_projects = %w()
    @user.projects.each do |p|
      if(p.status == "finished")
        @portfolio_projects << p
      end
    end
  end

  def edit
  end

  def update
  end

  def create
  end

  def destroy
  end

  def new
  end

end
