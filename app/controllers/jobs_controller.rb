class JobsController < ApplicationController
  def update
    @project = Project.find params[:id]
    
    # if no open jobs anymore
    if !params[:project].nil?
      params[:project][:job_ids]||={}
    else
      @project.jobs.clear
    end

    # collect old jobs (before update)
    oldJobs = Array.new
    @project.jobs.each do |j|
      oldJobs << j.id.to_s
    end


    if oldJobs.any? && oldJobs != params[:project][:job_ids]
      # get deleted jobs
      deletedJobs = oldJobs - params[:project][:job_ids]
      deletedJobs.each_with_index do |dj, key|
        deletedJobs[key] = @project.jobs.find(dj).name
      end

      if @project.update_attributes params[:project]
         # add statusupdate
         @project.statusupdates << Statusupdate.create(
           :content => Texttemplate.substitute(:job_delete, {"#jobs" => deletedJobs.join(', ')}), :isPublic => true, 
           :user => current_user, :html_tmpl_key => "JOBS2")
      else 
        redirect_to project_path
      end
    end

    # save new jobs
    if !params[:newjobs].nil?
    params[:newjobs].each do |job|
      Job.create :name => job, :project => @project
    end

    # add statusupdate
    @project.statusupdates << Statusupdate.create(
      :content => Texttemplate.substitute(:job_new, {"#jobs" => params[:newjobs].join(', ')}),  :isPublic => true, 
      :user => current_user, :html_tmpl_key => "JOBS")
    end

    respond_to do |format|
      format.js { render :nothing => true }
    end
  end
end
