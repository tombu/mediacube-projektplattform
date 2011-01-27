class ProjectsController < ApplicationController
  before_filter :check_user_role
  filter_resource_access #authorization

  def check_user_role 
    if !params[:id].nil?
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
  @countupdates = @statusupdates.count
  @statusupdates = @statusupdates.paginate :page => params[:page], :per_page => 10
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
    oldTeam = Array.new
    @project.team.each do |j|
      oldTeam << j.id
    end
    
    if @project.update_attributes params[:project]
      @deleted_members = oldTeam - params[:project][:role_ids]
      @deleted_members.each do |deleted_member|
        @project.team.each do |member|
          Notification.create(
              :sender_id=>deleted_member,
              :receiver_id=>member.id,
              :project_id=>@project.id,
              :isNew=>true,
              :html_tmpl_key=>"USER_LEAVE"
            )
        end
        Statusupdate.create(
          :content => Texttemplate.substitute(:team_delete, {"#user" => User.find(deleted_member).name}),
          :isPublic => true,
          :user_id => deleted_member,
          :project_id => @project.id,
          :html_tmpl_key => "TEAM_DELETE")
      end
      
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
    
    @project.currentstage = params[:crrent]
    @project.save

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
  @project.isInternal = true
  @project.status = "idea"
  if @project.save

    @role = Role.new(:role => "owner", :user => current_user, :project => @project, :job => params[:job][:name])
    if @role.save
      redirect_to project_path(@project)
    else
    flash[:notice] = ""
    render :new
    end
  else
    flash[:notice] = ""
    render :new
  end
  end
  
  def follow
    @project = Project.find params[:id]
    @role = Role.new(:role => "follower", :user => current_user, :project => @project, :job => nil)
    if @role.save
      flash[:notice] = "Du beobachtest dieses Projekt. Aktuelle Statusupdates findest du in deinem Dashboard."
      redirect_to @project and return
    end
    flash[:notice] = "Fehler beim Versuch, das Project zu beobachten."
    redirect_to @project
  end
  
  def unfollow
    @project = Project.find params[:id]
    @role = Role.where(:role => "follower", :user_id => current_user.id, :project_id => @project.id).first
    if @role.destroy
      flash[:notice] = "Du beobachtest dieses Projekt nun nicht mehr. Die Statusupdates wurden von deinem Dashboard entfernt."
      redirect_to @project and return
    end
    flash[:notice] = "Fehler beim Versuch..."
    redirect_to @project
  end
  
  def leave
    @project = Project.find params[:id]
    @role = Role.where(:user_id => current_user.id, :project_id => @project.id).first
    if @role.destroy
      flash[:notice] = "Du hast das Projekt verlassen."
      @project.team.each do |member|
          Notification.create(
              :sender_id=>current_user.id,
              :receiver_id=>member.id,
              :project_id=>@project.id,
              :isNew=>true,
              :html_tmpl_key=>"USER_LEAVE"
            )
        end
        Statusupdate.create(
          :content => Texttemplate.substitute(:team_delete, {"#user" => current_user.name}),
          :isPublic => true,
          :user_id => current_user.id,
          :project_id => @project.id,
          :html_tmpl_key => "TEAM_DELETE")
      redirect_to :back and return
    end
    flash[:notice] = "Fehler beim Versuch, das Projekt zu verlassen."
    redirect_to :back
  end
  
  def join
    user_id = (params[:receiver_id].nil?) ? current_user.id : params[:receiver_id]
    success = false
    @project = Project.find params[:id]
    @old_role = Role.where(:user_id => user_id, :project_id => @project.id, :role => "follower").first
    if @old_role.nil?
      if Role.create(:role => "member", :user_id => user_id, :project => @project)
        success = true
      end
    else
      if @old_role.update_attributes :role => "member"
        success = true
      end
    end
    
    if success
      Notification.find(params[:notification_id]).destroy
      
      @project.team.where("user_id != ?", user_id).each do |member|
        Notification.create(
            :sender_id=>user_id,
            :receiver_id=>member.id,
            :project_id=>@project.id,
            :isNew=>true,
            :html_tmpl_key=>"USER_NEW"
          )
       end
       Notification.create(
            :sender_id=>@project.owner.id,
            :receiver_id=>user_id,
            :project_id=>@project.id,
            :isNew=>true,
            :html_tmpl_key=>"ACCEPTED_TO_USER"
          )

      Statusupdate.create(
        :content => Texttemplate.substitute(:team_new),
        :isPublic => true,
        :user_id => user_id,
        :project_id => @project.id,
        :html_tmpl_key => "TEAM")
        
       redirect_to :back
     end
  end
  
  def apply
    if Notification.create(
        :sender_id=>current_user.id,
        :receiver_id=>@project.owner.id,
        :project_id=>@project.id,
        :isNew=>true,
        :html_tmpl_key=>"DECISION_TO_OWNER"
      )
      redirect_to :back, :notice => "Die Bewerbung wurde an den Projektleiter geschickt." and return
    end
    redirect_to :back, :notice => "Fehler beim Versuch, die Bewerbung an den Projektleiter zu schicken."
  end
  
end
