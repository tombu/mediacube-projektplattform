class SearchsController < ApplicationController
  def index
    @cat = params[:category]
    params[:search].lstrip!
    
    if params[:search].empty? || params[:search] == 'Suche nach'
      redirect_to :root
    else
      @results = search params
      @resultscount = @results.count
      @results = @results.paginate :page => params[:page], :per_page => 30
    end
  end
  
  def search search
    q = search[:search]
    case search[:category]
      when 'Projekte'
        Project.find :all, :conditions => ["title LIKE ? or description LIKE ?", "%#{q}%", "%#{q}%"]
      when 'Jobs'
        @open_projects = %w()
        @all_jobs = Job.find :all, :conditions => ["name LIKE ?", "%#{q}%"]
        @all_jobs.each do |job|
          if !job.project.roles.include? job.role
            if !@open_projects.include? job.project
              @open_projects << job.project
            end
          end
        end
        @open_projects
      when 'User'
        User.find :all, :conditions => ["name LIKE ? or mail LIKE ?", "%#{q}%", "%#{q}%"]
      else redirect_to :root
    end
  end
end
