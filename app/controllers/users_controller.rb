class UsersController < ApplicationController
  filter_resource_access
  
  def show
    @user = User.find params[:id]
  end
  
  def edit
    @user = current_user
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
  
end