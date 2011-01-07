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
        Project.find :all
      when 'users'
        Project.find :all
      else redirect_to :root
    end
  end
end
