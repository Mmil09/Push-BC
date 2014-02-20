class CourseMaterial < ActiveRecord::Base
  has_many :bootcamp_materials
  has_many :bootcamps, through: :bootcamp_materials
  validates :name, presence: true

end