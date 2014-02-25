class Review < ActiveRecord::Base
  validates :rating, :background, :instruction, :overall, presence: true
  validates_inclusion_of :rating, in: 1..5
  validates_length_of :background, :instruction, minimum: 150
  validates_length_of :overall, minimum: 300
  belongs_to :user
  belongs_to :bootcamp

end