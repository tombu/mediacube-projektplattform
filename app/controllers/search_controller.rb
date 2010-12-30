class SearchController < ApplicationController
  def index
    @searchs = Search.all
  end

end
