class ProjectsController < ApplicationController
  def index
    @projects = Project.where("isPublic = ?", true).paginate :page => params[:page], :per_page => 6
    puts @projects
  end

  def show
    @project = Project.find(params[:id])
    @owner = @project.roles.find_by_role :owner
    @mcount = @project.media.count
    @status_names = { "idea" => "Idee", "inprogress" => "In Arbeit", "finished" => "Abgeschlossen"}
  end

  def edit
    @project = Project.find params[:id]
    @owner = @project.roles.find_by_role :owner
    @mcount = @project.media.count
    @status_names = { "idea" => "Idee", "inprogress" => "In Arbeit", "finished" => "Abgeschlossen"}
  end
  
  def update
    @project = Project.find params[:id] 
    @field = params[:field]
    
    if @field == 'job'
      if !params[:project].nil?
        params[:project][:job_ids]||={}
      else
        @project.jobs.each do |job|
          job.destroy
        end
      end
      
      # update/delete existing jobs
      if @project.update_attributes params[:project]
        respond_to do |format|
          format.js { render :nothing => true }
        end 
      else redirect_to project_path
      end
      
      # save new jobs
      if !params[:newjobs].nil?
        params[:newjobs].each do |job|
          @job = Job.create :name => job, :project => @project
        end
      end
    elsif @field == 'info'
      params[:project][:category_ids] ||= {}
      if @project.update_attributes params[:project]
        respond_to do |format|
          format.js { render :nothing => true }
        end 
      else redirect_to project_path
      end
    elsif @field == 'team'
      params[:project][:role_ids] ||= {}
      if @project.update_attributes params[:project]
        respond_to do |format|
          format.js { render :nothing => true }
        end 
      else redirect_to project_path
      end
      @i = 0
      params[:roles].each do |jobn|
        @temprole = @project.roles.find_by_id(params[:project][:role_ids][@i])
        @temprole.job = jobn
        @temprole.save
        @i = @i+1
      end
    elsif @field == 'status'
      if @project.update_attributes params[:project]
        respond_to do |format|
          format.js { render :nothing => true }
        end 
      else redirect_to project_path
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
