class Review < ActiveRecord::Base

  BACKGROUND_WORDS = 150
  INSTRUCTION_WORDS = 150
  OVERALL_WORDS = 300
  
  validates :rating, :background, :instruction, :overall, presence: true
  validates_inclusion_of :rating, in: 1..5
  validates_length_of :overall, minimum: 300
  belongs_to :user
  belongs_to :bootcamp
  scope :review_exists?, ->(user_id, bootcamp_id) { where(user_id: user_id, bootcamp_id: bootcamp_id).count } 
  validate :reviewed_by_user?, before: :save
  validate :background_enough_words?, :instruction_enough_words?, :overall_enough_words?, before: :save


  def reviewed_by_user?
    errors.add(:bootcamp_id, "You have already reviewed this bootcamp.") if Review.review_exists?(self.user_id, self.bootcamp_id) > 0
  end

  def username
    self.user.username
  end

  def background_enough_words?
    enough_words?("background", BACKGROUND_WORDS) 
  end

  def instruction_enough_words?
    enough_words?("instruction", INSTRUCTION_WORDS)
  end

  def overall_enough_words?
    enough_words?("overall", OVERALL_WORDS) 
  end

  def enough_words?(section, min_words)
    errors.add(:section, "#{section} must have at least #{min_words}") if self.word_count(self.send(section)) < min_words 
  end

  def word_count(section)
    section.split.size if section != nil
  end

end