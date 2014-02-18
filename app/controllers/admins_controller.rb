class AdminsController < ApplicationController

  before_action :logged_in?, :is_admin?
  #before_action :is_admin?

  def new
  	 @admin = Admin.new
  end


end