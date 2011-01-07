class ProjectsController < ApplicationController
  def index
    if !params[:search]
      @projects = Project.where(:isInternal => true)
      @searchQuery = false
    else
      @projects = Project.search params[:search]
      @searchQuery = true
    end
  end

  def show
    @project = Project.find params[:id]
    @open_jobs = get_open_jobs()
    @owner = @project.roles.where(:role => 'owner').first
  end
  
  def get_open_jobs
    open_jobs = %w()
    @project.jobs.each do |j|
      if(!(@project.roles.include?(j.role)))
        open_jobs << j
      end
    end
    return open_jobs
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
