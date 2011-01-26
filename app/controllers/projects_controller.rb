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
  @statusupdates = @project.statusupdates.order('created_at DESC').paginate :page => params[:page], :per_page => 10
  end

  def edit
  # @project = ... set by authorization
  @owner = @project.roles.find_by_role :owner
  @mcount = @project.images.count
  @status_names = { "idea" => "Idee", "inprogress" => "In Arbeit", "finished" => "Abgeschlossen"}
  @privacy = @project.privacy_setting
  end

  def update
  # @project = ... set by authorization
  @field = params[:field]
  puts params

  if @field == 'job'
    if(!params[:project].nil?) 
    params[:project][:job_ids]||={}
    else @project.jobs.clear
    end

    oldJobs = Array.new
    @project.jobs.each do |j|
    oldJobs << j.id.to_s
    end

    if oldJobs != params[:project][:job_ids]
    deletedJobs = oldJobs - params[:project][:job_ids]

    deletedJobs.each_with_index do |dj, key|
      deletedJobs[key] = @project.jobs.find(dj).name
    end

    if @project.update_attributes params[:project]
     # add statusupdate
     @project.statusupdates << Statusupdate.create(
       :content => Texttemplate.substitute(:job_delete, {"#jobs" => deletedJobs.join(', ')}), 
       :isPublic => true, 
       :user => current_user,
       :html_tmpl_key => "JOBS2")

    else redirect_to project_path
    end
    end

    # save new jobs
    if !params[:newjobs].nil?
    params[:newjobs].each do |job|
      Job.create :name => job, :project => @project
    end
    # add statusupdate
    @project.statusupdates << Statusupdate.create(
      :content => Texttemplate.substitute(:job_new, {"#jobs" => params[:newjobs].join(', ')}), 
      :isPublic => true, 
      :user => current_user,
      :html_tmpl_key => "JOBS")
    end

    respond_to do |format|
    format.js { render :nothing => true }
    end

  # update general project infos
  elsif @field == 'info'
    params[:project][:category_ids] ||= {}
    if @project.update_attributes params[:project]
    # add statusupdate
    @project.statusupdates << Statusupdate.create(
      :content => Texttemplate.substitute(:project_edit), 
      :isPublic => true, 
      :user => current_user,
      :html_tmpl_key => "EDIT")

    respond_to do |format|
      format.js { render :nothing => true }
    end 
    else redirect_to project_path
    end

  # update team members
  elsif @field == 'team'
    params[:project][:role_ids] ||= {}
    if @project.update_attributes params[:project]
    respond_to do |format|
      format.js { render :nothing => true }
    end 
    else redirect_to project_path
    end
    params[:roles].each_with_index do |jobnew, key|
    @temprole = @project.roles.find_by_id(params[:project][:role_ids][key])
    @temprole.job = jobnew
    @temprole.save
    end

  # update stages
  elsif @field == 'stages'

    # cast hash or delete all stages if empty
    if(!params[:project].nil?)
      params[:project][:stage_ids]||={}
      @project.update_attributes params[:project]
    else @project.stages.clear
    end

    # save new stages
    if !params[:newstages].nil?
    params[:newstages][:name].each_with_index do |s, key|
      Stage.create :name => params[:newstages][:name][key], :position => params[:newstages][:position][key], :project => @project
    end
    end

    if !params[:stages].nil?
    params[:stages][:name].each_with_index do |stage_name, key|
      @tempstage = @project.stages.find_by_id params[:stages][:sid][key]
      if !@tempstage.nil?
      @tempstage.name = stage_name
      @tempstage.position = params[:stages][:position][key]
      @tempstage.save
      end
    end
    end

    respond_to do |format|
    format.js { render :nothing => true }
    end

  # update status
  elsif @field == 'status'
    if @project.update_attributes params[:project]
    # add statusupdate
    @project.statusupdates << Statusupdate.create(
      :content => Texttemplate.substitute(:project_status_edit, {"#status" => Project.parse_status(params[:project][:status])}), 
      :isPublic => true, 
      :user => current_user,
      :html_tmpl_key => "STATUS")
    respond_to do |format|
      format.js { render :nothing => true }
    end 
    else redirect_to project_path
    end

  else
    params[:project][:privacy_setting_id]||={}
    if @project.update_attributes params[:project][:privacy_setting_id]
    redirect_to edit_project_path
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
