class MediaController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @media = @project.media.all
    @mcount = @project.media.count
  end

  def new
  end

  def create
    @medium = Medium.new(:asset => params[:file], :project_id => params[:project_id])
    @medium.save
    if params[:project_cover]
      # redirect_to :root
    end
  end

  def destroy
  end

end
