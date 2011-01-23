class ProjectsController < ApplicationController
  before_filter :check_user_role
  filter_resource_access #authorization
  
  def check_user_role 
    if !params[:id].nil? #|| params[:controller] == "media"
      current_user.current_role = current_user.roles.where(:project_id => params[:id])
    end
  end
  
  def index
    @status_names = { "Idee" => "idea", "In Arbeit" => "inprogress", "Abgeschlossen" => "finished"}
    @status = @status_names[params[:status]]
    
    if !params[:category].nil? && !params[:status].nil?
      @projects = Project.joins(:categories).where(:categories => {:label => params[:category]}).where("isPublic = ? AND status = ?", true, @status)
    elsif !params[:category].nil?
      @projects = Project.joins(:categories).where(:categories => {:label => params[:category]}).where "isPublic = ?", true
    elsif !params[:status].nil?
      @projects = Project.where("isPublic = ? AND status = ?", true, @status)
    else
      @projects = Project.where "isPublic = ?", true
    end
    @projects = @projects.paginate :page => params[:page], :per_page => 6
  end

  def show
    # @project = ... set by authorization
    @owner = @project.roles.find_by_role :owner
    @mcount = @project.images.count
    @status_names = { "idea" => "Idee", "inprogress" => "In Arbeit", "finished" => "Abgeschlossen"}
    @statusupdates = @project.statusupdates.order('created_at DESC')
  end

  def edit
    # @project = ... set by authorization
    @owner = @project.roles.find_by_role :owner
    @mcount = @project.images.count
    @status_names = { "idea" => "Idee", "inprogress" => "In Arbeit", "finished" => "Abgeschlossen"}
  end
  
  def update
    # @project = ... set by authorization
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
    # @project = ... set by authorization
  end
  
  def create    
    # @project = ... set by authorization
    @project.isPublic = (params[:project][:isPublic].to_i.zero? ?  false :  true)
    @project.isInternal = true
    @project.status = "idea"
    if @project.save
      params[:categories].each do |cat|
        @project.categories << Category.find(cat[:id]) unless cat[:id].blank?
      end
    
      @job = Job.new(:name => params[:job][:name], :project => @project)
      @role = Role.new(:role => "owner", :user => current_user, :project => @project, :job => @job)
      if @job.save && @role.save
        redirect_to new_project_medium_path(@project, :build_cover => true)
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
