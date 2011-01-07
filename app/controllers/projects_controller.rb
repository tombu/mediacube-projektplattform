class ProjectsController < ApplicationController
  def index
    @projects = Project.paginate :page => params[:page], :per_page => 6
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
    @project = Project.new
  end
  
  def create
    # @medium = Medium.create(:label => "", :link => "")
    
    @project = Project.new(params[:project])
    params[:project][:isPublic] == "1" ? @project.isPublic = true : @project.isPublic = false
    @project.isInternal = true
    # @project.picture = @medium
    @project.save

    params[:categories].each do |cat|
      @project.categories << Category.find(cat[:id]) unless cat[:id].blank?
    end
    
    @job = Job.create(:name => params[:job][:name], :project => @project)
    @role = Role.create(:role => "owner", :user => User.first, :project => @project, :job => @job)
    
  end
  
end
