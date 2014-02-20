class BootcampMaterial < ActiveRecord::Base
  belongs_to :bootcamp
  belongs_to :course_material
end