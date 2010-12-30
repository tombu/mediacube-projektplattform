class ProjectsController < ApplicationController
  def index
    if !params[:search]
      @projects = Project.all
      @searchQuery = false
    else
      @projects = Project.search(params[:search])
      @searchQuery = true
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
  end

  def new
  end
end
