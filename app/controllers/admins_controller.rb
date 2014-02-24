class AdminsController < ApplicationController

  before_action :require_log_in, :require_admin

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      flash[:success] = "Administrator successfully created!"
      redirect_to(root_path)
    else
      flash[:error] = "Please review your input.  There was an error."
      render(:new)
    end

  end

  private

  def admin_params
    params.require(:admin).permit(:username, :password, :email).merge(type: "Admin")
  end

end