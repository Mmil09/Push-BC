class BootcampsController < ApplicationController
  before_action :logged_in?, :is_admin?, except: [:show]

  def new
    @bootcamp = Bootcamp.new
  end

  def create
    @bootcamp = Bootcamp.new(bootcamp_params)
    if @bootcamp.save
      flash[:success] = "Bootcamp successfully created!"
      redirect_to(bootcamp_path(@bootcamp))
    else
      render :new
    end
  end

  def show
    @bootcamp = Bootcamp.find_by_slug(params[:id])
  end

  private

  def bootcamp_params
    params.require(:bootcamp).permit(:name, :description, :format, :length, :class_size, :sessions, :hours, :minimum_skill, :placement_test, :prep_work, :cost, :refund, :financing, :deposit, :payment_plan, :job_assistance, :housing, :visa_assistance, :email, :phone, :address, :city, :state, :country, :website)
  end

end
