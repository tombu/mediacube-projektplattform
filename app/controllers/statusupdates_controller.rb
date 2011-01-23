class StatusupdatesController < ApplicationController
  def index
    @statusupdates = Statusupdate.joins(:project => {:roles => :user}).where(:users => {:id => current_user.id}).order('created_at DESC')
  end
  
  def new
  end
  
  def create
    @statusupdate = Statusupdate.new params[:statusupdate]
    if @statusupdate.save
      flash[:notice] = "Statusupdate gespeichert!"
      redirect_to :back
    else
      flash[:notice] = "Fehler beim Speichern des Statusupdates!"
      redirect_to :back
    end
  end
  
  def destroy
  end

end
