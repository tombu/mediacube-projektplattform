class Job < ActiveRecord::Base
  belongs_to :project
  
  def self.projects_with_open_jobs query
    @all_jobs = Job.find :all, :conditions => ["name LIKE ?", "%#{query}%"]
    @open_projects = @all_jobs.map { |job| job.project unless (@open_projects ||= []).include? job.project }
    return @open_projects
  end
end