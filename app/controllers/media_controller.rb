class MediaController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @media = @project.media.all
  end

  def show
    @project = Project.find(params[:project_id])
    @medium = @project.media.find(params[:id])
  end

  def new
    @project = Project.find(params[:project_id])
  end

  def create
    @project = Project.find(params[:project_id])
    if params[:project_cover] == true.to_s
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
