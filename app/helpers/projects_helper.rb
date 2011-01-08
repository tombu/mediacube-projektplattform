module ProjectsHelper
  def get_open_jobs project
    open_jobs = %w()
    project.jobs.each do |j|
      if(!(project.roles.include?(j.role)))
      open_jobs << j
      end
    end
    return open_jobs
  end
   
end
