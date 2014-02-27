class ReviewsController < ApplicationController

  before_action :require_log_in, :require_standard_user

  def create
    @review = Review.new(review_params)
    if @review.save
      flash[:success] = "Your review has been saved."
      redirect_to(bootcamp_path(bootcamp))
    else
      flash[:error] = "Your review could not be created."
      render "bootcamps/show"
    end
  end

  private

  def bootcamp
    Bootcamp.find_by_slug(params[:bootcamp_id])
  end

  def review_params
    params.require(:review).permit(:rating, :background, :instruction, :overall).merge(bootcamp_id: bootcamp.id, user_id: current_user)
  end

end