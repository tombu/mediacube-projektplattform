class Search < ActiveRecord::Base
  def self.search search
    q = search[:search]
    case search[:category]
      when 'Projekte'
        Project.find :all, :conditions => ["title LIKE ? or description LIKE ?", "%#{q}%", "%#{q}%"]
      when 'Jobs'
        @open_projects = Job.projects_with_open_jobs q
      when 'User'
        User.find :all, :conditions => ["name LIKE ? or mail LIKE ?", "%#{q}%", "%#{q}%"]
      else redirect_to :root
    end
  end
end
