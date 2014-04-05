class RepliesController < ApplicationController
  before_action :require_log_in
  before_action { require_bc_admin(bootcamp) }


  def create
    @reply = Reply.new(response_params)
    if @reply.save
      flash[:success] = "Response was successfully created."
    else
      flash[:error] = "There was an error with your input."
    end
    redirect_to :back
  end

  private

  def bootcamp
    Bootcamp.find(review.bootcamp_id)
  end

  def review
    Review.find(params[:review_id])
  end

  def response_params
    params.permit(:response, :review_id).merge(user_id: current_user)
  end
end