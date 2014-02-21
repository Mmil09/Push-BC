class CourseMaterial < ActiveRecord::Base

  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  has_many :bootcamp_materials
  has_many :bootcamps, through: :bootcamp_materials
  validates :name, presence: true

end