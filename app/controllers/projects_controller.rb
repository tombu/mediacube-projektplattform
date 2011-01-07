class ProjectsController < ApplicationController
  def index
      @projects = Project.paginate(:page => params[:page], :per_page => 3)
  end

  def show
    @project = Project.find params[:id]
    @owner = @project.roles.where(:role => 'owner').first
    @status_names = { "idea" => "Idee", "inprogress" => "In Arbeit", "finished" => "Abgeschlossen"}
  end

  def edit
    @project = Project.find params[:id] 
  end
  
  def update
    @project = Project.find params[:id] 

    respond_to do |format|
      if @project.update_attributes params[:project] 
        redirect_to @project, :notice => 'Project was successfully updated.'
      else
        render :action => "edit"
      end
    end
  end

  def new
  end
end
