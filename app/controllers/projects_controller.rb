class ProjectsController < ApplicationController
  before_filter :check_user_role
  filter_resource_access #authorization

  def index
    @status = Project.parse_status params[:status]
    # filter by category or status and sort
    @projects = Project.filter_projects(params[:category], params[:status]).is_public.sorted.paginate(:page => params[:page], :per_page => 15)
  end

  def show
    @owner = @project.roles.find_by_role :owner
    @count_images = @project.images.count
    @statusupdates = @project.statusupdates.sorted.paginate :page => params[:page], :per_page => 10
  end

  def edit
    @privacy = @project.privacy_setting
  end

  def update
    case params[:field]
      when 'info'
        params[:project][:category_ids] ||= {}
        @project.update_attributes params[:project]
      when 'status'
        @project.update_attributes params[:project]
    end
    
    respond_to do |format|
      format.js { render :nothing => true }
    end
  end

  def create
    @project.isInternal = true
    @project.status = "idea"
    if @project.save
      @role = Role.new(:role => "owner", :user => current_user, :project => @project, :job => params[:project][:role][:job])
      if @role.save
        redirect_to @project, :notice=>"Projekt wurde erfolgreich erstellt!" and return
      end
    end
    redirect_to :back, :error=>"Projekt konnte nicht erstellt werden!"
  end
  
  def follow
    @project = Project.find params[:id]
    @role = Role.new(:role => "follower", :user => current_user, :project => @project, :job => nil)
    if @role.save
      flash[:notice] = "Du beobachtest nun dieses Projekt. Aktuelle Statusupdates findest du in deinem Dashboard."
    else 
      flash[:notice] = "Es ist ein Fehler aufgetreten!" 
    end
    redirect_to @project and return
  end
  
  def unfollow
    @project = Project.find params[:id]
    @role = Role.where(:role => "follower", :user_id => current_user.id, :project_id => @project.id).first
    if @role.destroy
      flash[:notice] = "Du beobachtest dieses Projekt nun nicht mehr!"
    else 
      flash[:notice] = "Es ist ein Fehler aufgetreten!"
    end
    redirect_to @project and return
  end
  
  def leave
    @project = Project.find params[:id]
    @role = Role.where(:user_id => current_user.id, :project_id => @project.id).first
    if @role.destroy
      @project.team(true).each do |member|
        Notification.create( 
          :sender_id=>current_user.id, :receiver_id=>member.id, :project_id=>@project.id,
          :isNew=>true, :html_tmpl_key=>"USER_LEAVE")
      end
      Statusupdate.create(
        :content => Texttemplate.substitute(:team_delete, {"#user" => current_user.name}), :isPublic => true, :user_id => current_user.id,
        :project_id => @project.id, :html_tmpl_key => "TEAM_DELETE")
    else 
      flash[:notice] = "Fehler beim Versuch, das Projekt zu verlassen."
    end
    redirect_to :back and return
  end
  
  def join
    user_id = (params[:receiver_id].nil?) ? current_user.id : params[:receiver_id]
    success = false
    @project = Project.find params[:id]
    @old_role = Role.where(:user_id => user_id, :project_id => @project.id, :role => "follower").first
    if @old_role.nil?
      success = true if Role.create(:role => "member", :user_id => user_id, :project => @project)
    else
      success = true if @old_role.update_attributes :role => "member"
    end
    
    if success
      Notification.find(params[:notification_id]).destroy
      
      @project.team(true).where("user_id != ?", user_id).each do |member|
        Notification.create(
          :sender_id=>user_id, :receiver_id=>member.id, :project_id=>@project.id,
          :isNew=>true, :html_tmpl_key=>"USER_NEW")
      end
      if !params[:dtu]
        Notification.create(
          :sender_id=>@project.owner.id, :receiver_id=>user_id, :project_id=>@project.id,
          :isNew=>true, :html_tmpl_key=>"ACCEPTED_TO_USER")
      end
      
      Statusupdate.create(
        :content => Texttemplate.substitute(:team_new), :isPublic => true, :user_id => user_id,
        :project_id => @project.id, :html_tmpl_key => "TEAM")
       
      redirect_to :back and return
    else
      redirect_to :back, :error => "Es ist ein Fehler aufgetreten!"
    end
  end
  
  def apply
    if Notification.create(
        :sender_id=>current_user.id, :receiver_id=>@project.owner.id, :project_id=>@project.id,
        :isNew=>true, :html_tmpl_key=>"DECISION_TO_OWNER")
      redirect_to :back, :notice => "Die Bewerbung wurde verschickt!" and return
    end
    redirect_to :back, :error => "Die Bewerbung konnte leider nicht verschickt werden!"
  end
    
  def check_user_role
    if !params[:id].nil?
      current_user.current_role = current_user.roles.where(:project_id => params[:id])
    elsif params[:controller] == "media"
      current_user.current_role = current_user.roles.where(:project_id => params[:project_id])
    end
  end
end