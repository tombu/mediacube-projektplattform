class StatusupdatesController < ApplicationController
  # :filter_access_to 
  
  def index
    @statusupdates = Statusupdate.joins(:project => {:roles => :user}).where(:users => {:id => current_user.id}).order('created_at DESC')
  end
  
  def new
  end
  
  def create
    @statusupdate = Statusupdate.new params[:statusupdate]
    @statusupdate.isPublic = true
    @statusupdate.html_tmpl_key = "POST"
    
    if @statusupdate.save
      flash[:notice] = "Statusupdate gespeichert!"
    else
      flash[:notice] = "Fehler beim Speichern des Statusupdates!"
    end
    respond_to do |format|
      format.js { render :nothing => true }
    end
  end
  
  def destroy
  end

end
