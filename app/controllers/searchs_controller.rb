class SearchsController < ApplicationController
  def index
    @cat = params[:category]
    if params[:search].empty?
      redirect_to :root
    else
      @results = search(params).paginate(:page => params[:page], :per_page => 10)
    end
  end
  
  def search search
    q = search[:search]
    case search[:category]
      when 'projects'
        Project.find :all, :conditions => ["title LIKE ? or description LIKE ?", "%#{q}%", "%#{q}%"]
      when 'jobs'
        @open_projects = %w()
        @all_jobs = Job.find :all, :conditions => ["name LIKE ?", "%#{q}%"]
        @all_jobs.each do |job|
          if !job.project.roles.include? job.role 
            @open_projects << job.project 
          end
        end
        @open_projects
      when 'users'
        Project.find :all
      else redirect_to :root
    end
  end
end
