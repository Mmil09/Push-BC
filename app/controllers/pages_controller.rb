class PagesController < ApplicationController
  before_action :set_page, only: [:show]

  
  def index

  end

  def show
    add_breadcrumb @page.title, page_path(@page) 
    
  end


  def set_page
    @page = Page.find_by_slug(params[:id])
  end

 

end