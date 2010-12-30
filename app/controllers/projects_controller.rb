class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
    @open_jobs = get_open_jobs()
  end
  
  def get_open_jobs
    open_jobs = %w()
    @project.jobs.each do |j|
      if(!(@project.roles.include?(j.role)))
        open_jobs << j
      end
    end
    return open_jobs
  end

  def edit
  end

  def new
  end

end