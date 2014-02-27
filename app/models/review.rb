class Review < ActiveRecord::Base
  validates :rating, :background, :instruction, :overall, presence: true
  validates_inclusion_of :rating, in: 1..5
  validates_length_of :background, :instruction, minimum: 150
  validates_length_of :overall, minimum: 300
  belongs_to :user
  belongs_to :bootcamp
  scope :review_exists?, ->(user_id, bootcamp_id) { where(user_id: user_id, bootcamp_id: bootcamp_id) } 
  validate :reviewed_by_user?, on: :save
  
  def reviewed_by_user?
    errors.add(:bootcamp_id, "You have already reviewed this bootcamp.") if Review.review_exists?(self.user_id, self.bootcamp_id).count > 0
  end

  def username
    self.user.username
  end

end