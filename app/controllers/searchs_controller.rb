class SearchsController < ApplicationController
  def index
    @cat = params[:category]
    params[:search].lstrip!
    
    if params[:search].empty?
      redirect_to :root
    else
      @results = Search.search(params).paginate :page => params[:page], :per_page => 30
    end
  end
end
