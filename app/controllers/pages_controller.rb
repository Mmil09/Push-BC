class PagesController < ApplicationController
  before_action :set_page, only: [:show]
  
  def index

  end

  def show
    
  end


  def set_page
    @page = Page.find_by_slug(params[:id])
  end
end