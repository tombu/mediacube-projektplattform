# encoding: utf-8
class UsersController < ApplicationController
  
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

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Die Änderungen wurden erfolgreich übernommen."
      redirect_to user_path(current_user) and return
    end
    flash[:notice] = "Fehler beim Aktualisieren. Die Änderungen konnten nicht übernommen werden."
    redirect_to :back
  end

  def destroy
  end
  
end
