class Bootcamp <ActiveRecord::Base
  validates :name, :description, presence: true
  validates :length, :deposit, numericality: { only_integer: true }
  validates :cost, numericality: true
  has_many :user_bootcamps
  has_many :users, through: :user_bootcamps
  has_many :bootcamp_materials
  has_many :course_materials, through: :bootcamp_materials
end