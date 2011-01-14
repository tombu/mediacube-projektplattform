class MediaController < ApplicationController
  filter_resource_access :nested_in => :projects
  
  def index
    @project = Project.find(params[:project_id])
    @images = @project.images.all
    @icount = @project.images.count
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
      @cover = Cover.create(:asset => params[:file], :project_id => params[:project_id])
      @project.cover = @cover
      @project.save
    else
      Image.create(:asset => params[:file], :project_id => params[:project_id])
    end
  end

  def destroy
  end

end
