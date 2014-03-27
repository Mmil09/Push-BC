class Reply < ActiveRecord::Base
  belongs_to :review
  belongs_to :user
  validates :response, presence: true
end