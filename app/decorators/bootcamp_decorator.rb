class BootcampDecorator < Draper::Decorator
  delegate_all

  def show_review_form
    if !h.current_user
      "You must log in to write a review."
    else 
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



end
