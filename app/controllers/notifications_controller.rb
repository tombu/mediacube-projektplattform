class NotificationsController < ApplicationController
  def create
    if params[:invitation]
      Notification.create(
        :sender_id=>current_user.id,
        :receiver_id=>User.find_by_name(params[:username]).id,
        :project_id=>params[:project_id],
        :isNew=>true,
        :html_tmpl_key=>"DECISION_TO_USER"
      )
    end
    redirect_to :back, :notice => "Die Einladung wurde verschickt."
  end

  def destroy
    @notification = Notification.find(params[:id])
    @receiver = @notification.sender_id
    @notification.destroy

    if !params[:notify].nil?
      @project = Project.find_by_id params[:project_id]
      
      Notification.create(
        :sender_id=>current_user.id,
        :receiver_id=>@receiver,
        :project_id=>@project.id,
        :isNew=>true,
        :html_tmpl_key=>params[:notify]
      )
    end
    
    respond_to do |format|
      format.js { render :nothing => true }
    end
  end
  
  def mark_as_read
    puts params
    unread_notifications = Notification.where(:receiver_id=>current_user.id)
    unread_notifications.each do |n|
        n.isNew = false
        n.save
    end
    redirect_to :back
  end
end