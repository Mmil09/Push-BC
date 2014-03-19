class Reply < ActiveRecord::Base
  belongs_to :review
  belongs_to :bc_admin
  validates :response, presence: true
end