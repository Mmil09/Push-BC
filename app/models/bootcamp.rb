class Bootcamp <ActiveRecord::Base
  extend FriendlyId
  include Sluggable

  friendly_id :name, use: [:slugged, :history]
  validates :name, :description, presence: true
  validates :length, :deposit, numericality: { only_integer: true }, allow_blank: true, allow_nil: true
  validates :cost, numericality: true, allow_blank: true, allow_nil: true
  has_many :user_bootcamps
  has_many :users, through: :user_bootcamps
  has_many :bootcamp_materials
  has_many :course_materials, through: :bootcamp_materials

  

end