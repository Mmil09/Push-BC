class BCAdmin < User

  

  def already_replied_to_review?(review_id)
    reply_exists?(review_id) > 0 ? true : false
  end

  private

  def reply_exists?(review_id)
    Reply.where(review_id: review_id, user_id: self.id).count
  end

end