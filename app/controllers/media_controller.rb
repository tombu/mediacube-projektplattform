class MediaController < ApplicationController
  before_filter :check_user_role
  filter_resource_access :nested_in => :projects
  
  def check_user_role 
    current_user.current_role = current_user.roles.where(:project_id => params[:project_id])
  end
  
  def index
    @project = Project.find(params[:project_id])
    @images = @project.images.sorted.all
  end

  def new
    @project = Project.find(params[:project_id])
  end

  def create    
    @project = Project.find(params[:project_id])
        
    if params[:project_cover] == true.to_s
      if !@project.cover.nil?
        @project.cover.destroy
      end
      @project.cover = Cover.create(:asset => params[:file], :project_id => params[:project_id])
      @project.save
    else
      if @project.media.any?
        distance = ((Time.now.to_time - @project.media.last.created_at.to_time).abs).round
      else
        distance = 1000
      end
      
      @project.images.create(:asset => params[:file])
      
      # add statusupdate
      if distance > 60
        @project.statusupdates.create(
          :content => Texttemplate.substitute(:media_new, {"#user" => current_user.name}), 
          :isPublic => true,
          :user => current_user,
          :html_tmpl_key => "MEDIA")
      end
    end
  end

  def destroy
  end

end
