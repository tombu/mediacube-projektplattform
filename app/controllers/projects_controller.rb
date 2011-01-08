class ProjectsController < ApplicationController
  def index
    @projects = Project.paginate :page => params[:page], :per_page => 6
    puts @projects
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
    @project = Project.new(params[:project])
    @project.isPublic = (params[:project][:isPublic].to_i.zero? ?  false :  true)
    @project.isInternal = true
    if @project.save
      params[:categories].each do |cat|
        @project.categories << Category.find(cat[:id]) unless cat[:id].blank?
      end
    
      @job = Job.new(:name => params[:job][:name], :project => @project)
      @role = Role.new(:role => "owner", :user => User.last, :project => @project, :job => @job)
      if @job.save && @role.save
        redirect_to new_project_medium_path(@project, :build_cover => true)
        flash[:notice] = ""
      else
        flash[:notice] = ""
        render :new
      end
    else
      flash[:notice] = ""
      render :new
    end
  end
  
end
