class BootcampDecorator < Draper::Decorator
  delegate_all

  def show_review_form
    if !h.current_user
      "You must log in to write a review."
    elsif !h.bc_admin?
      display_form?
    end

  end

  def display_form?
    if self.current_user_reviewed?(h.current_user)
      "You have already reviewed this."
    else
      h.render('show_review_form')
    end
  end

  def display_reply_form?(review)
    h.render('show_reply_form', review: review) if bc_admin_can_reply?(review.id)
  end

  private

  def bc_admin_can_reply?(review_id)
    true if h.bc_admin_of?(self.bootcamp) && !User.find(h.current_user).already_replied_to_review?(review_id)
  end

end
