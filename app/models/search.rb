class Search < ActiveRecord::Base
  def self.search search
    q = search[:search]
    case search[:category]
      when 'Projekte'
        Project.find :all, :conditions => ["isPublic = ? AND (title LIKE ? OR description LIKE ?)", true, "%#{q}%", "%#{q}%"]
      when 'Jobs'
        Job.projects_with_open_jobs q
      when 'User'
        User.find :all, :conditions => ["name LIKE ? or email LIKE ?", "%#{q}%", "%#{q}%"]
      else redirect_to :root
    end
  end
end
