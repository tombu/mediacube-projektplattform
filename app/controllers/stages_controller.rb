class StagesController < ApplicationController
  def update
    @project = Project.find params[:id]
    
    # cast hash or delete all stages if empty
    if(!params[:project].nil?)
      params[:project][:stage_ids]||={}
      @project.update_attributes params[:project]
    else @project.stages.clear
    end

    # save new stages
    if !params[:newstages].nil?
      params[:newstages][:name].each_with_index do |s, key|
        Stage.create :name => params[:newstages][:name][key], :position => params[:newstages][:position][key], :project => @project
      end
    end

    if !params[:stages].nil?
      params[:stages][:name].each_with_index do |stage_name, key|
        @tempstage = @project.stages.find_by_id params[:stages][:sid][key]
        if !@tempstage.nil?
        @tempstage.name = stage_name
        @tempstage.position = params[:stages][:position][key]
        @tempstage.save
        end
      end
    end

    @project.currentstage = params[:crrent]
    @project.save

    respond_to do |format|
    format.js { render :nothing => true }
    end
  end
end
