class Job < ActiveRecord::Base
  belongs_to :project
  
  def self.projects_with_open_jobs query
    @open_projects = %w()
    @all_jobs = Job.find :all, :conditions => ["name LIKE ?", "%#{query}%"]
    @all_jobs.each do |job|
      @open_projects << job.project if !@open_projects.include? job.project
    end
    @open_projects
  end
end