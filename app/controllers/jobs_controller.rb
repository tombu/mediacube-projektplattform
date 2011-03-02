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
    oldJobs = @project.jobs.map { |j| j.id.to_s }

    if oldJobs.any? && oldJobs != params[:project][:job_ids]
      # get deleted jobs
      deletedJobs = oldJobs - params[:project][:job_ids]
      deletedJobs.each_with_index do |dj, key|
        deletedJobs[key] = @project.jobs.find(dj).name
      end

      if @project.update_attributes params[:project]
         # add statusupdate
         @project.statusupdates.create(
           :content => Texttemplate.substitute(:job_delete, {"#jobs" => deletedJobs.join(', ')}), :isPublic => true, 
           :user => current_user, :html_tmpl_key => "JOBS2")
      end
    end

    # save new jobs
    if !params[:newjobs].nil?
    params[:newjobs].each do |job|
      Job.create :name => job, :project => @project
    end

    # add statusupdate
    @project.statusupdates.create(
      :content => Texttemplate.substitute(:job_new, {"#jobs" => params[:newjobs].join(', ')}),  :isPublic => true, 
      :user => current_user, :html_tmpl_key => "JOBS")
    end

    respond_to do |format|
      format.js { render :nothing => true }
    end
  end
end
