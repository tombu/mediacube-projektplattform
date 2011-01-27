class MediaController < ApplicationController
  #filter_resource_access :nested_in => :projects
  
  def index
    @project = Project.find(params[:project_id])
    @images = @project.images.all
    @icount = @project.images.count
  end

  def new
    @project = Project.find(params[:project_id])
  end

  def create
    puts params
    
    @project = Project.find(params[:project_id])
    distance = ((Time.now.to_time - @project.media.last.created_at.to_time).abs).round
    
    if params[:project_cover] == true.to_s
      if !@project.cover.nil?
        @project.cover.destroy
      end
      @cover = Cover.create(:asset => params[:file], :project_id => params[:project_id])
      @project.cover = @cover
      @project.save
    else
      Image.create(:asset => params[:file], :project_id => params[:project_id])
      
      # add statusupdate
      if distance > 60
        @project.statusupdates << Statusupdate.create(
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
