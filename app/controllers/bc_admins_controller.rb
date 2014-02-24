class BcAdminsController < ApplicationController

  before_action :require_log_in, :require_admin

  def new
    @bc_admin = BCAdmin.new
  end

  def create
    @bc_admin = BCAdmin.new(bc_admin_params)
    create_bootcamp_associations
    if @bc_admin.save
      flash[:success] = "Boot Camp Administrator successfully created!"
      redirect_to(root_path)
    else
      flash[:error] = "Please review your input.  There was an error."
      render(:new)
    end
  end

  private

  def bc_admin_params
    params.require(:bc_admin).permit(:username, :password, :email).merge(type: "BCAdmin")
  end

  def create_bootcamp_associations
    params[:bc_admin][:bootcamp_ids].each do |bootcamp|
      @bc_admin.bootcamps << Bootcamp.find(bootcamp)  
    end
  end 


end
