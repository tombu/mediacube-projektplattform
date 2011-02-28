class DashboardsController < ApplicationController
  def index
    @statusupdates = Statusupdate.dashboard(current_user).paginate(:page => params[:page], :per_page => 20)
  end
end