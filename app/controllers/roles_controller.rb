class RolesController < ApplicationController
  def update
    @project = Project.find params[:id]

    oldTeam = Array.new
    @project.team(true).each do |j|
      oldTeam << j.id
    end
    newTeam = Array.new
    params[:project][:role_ids].each do |r|
      newTeam << Role.find(r).user_id
    end

    params[:project][:role_ids] ||= {}
    if @project.update_attributes params[:project]
      @deleted_members = oldTeam - newTeam
      @deleted_members.each do |del_id|
        @project.team.each do |member|
          Notification.create(
              :sender_id=>del_id, :receiver_id=>member.id, :project_id=>@project.id,
              :isNew=>true, :html_tmpl_key=>"USER_LEAVE")
        end
        Statusupdate.create(
          :content => Texttemplate.substitute(:team_delete, {"#user" => User.find(del_id).name}), :isPublic => true, :user_id => del_id,
          :project_id => @project.id, :html_tmpl_key => "TEAM_DELETE")
      end

      respond_to do |format|
        format.js { render :nothing => true }
      end 
    else redirect_to project_path
    end
    params[:roles].each_with_index do |jobnew, key|
      @temprole = @project.roles.find_by_id(params[:project][:role_ids][key])
      @temprole.job = jobnew
      @temprole.save
    end
  end
end
