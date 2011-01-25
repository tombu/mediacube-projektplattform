class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
    @active_projects = %w()
    @all_projects = %w()
    @user.is_involved.each do |r|
      if r.project.status != 'finished'
        @active_projects << r.project
      end
      @all_projects << r.project
    end
    @following_projects = %w()
    @user.is_following.each do |role|
      @following_projects << role.project
    end
    
    @portfolio_projects = %w()
    @user.is_involved.each do |role|
      if(role.project.status == "finished")
        @portfolio_projects << role.project
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  def follow project
    @role = Role.new(:role => "follower", :user => current_user, :project => project, :job => nil)
    if @role.save
      flash[:notice] = "Du beobachtest dieses Projekt. Aktuelle Statusupdates findest du in deinem Dashboard."
      redirect_to project and return
    end
    flash[:notice] = "Fehler beim Versuch, das Project zu beobachten"
    redirect_to project
  end
  
    def open_notifications
   puts "OOOOOOOOOOOOOOOOOOOOOOOOO"
  end

end
