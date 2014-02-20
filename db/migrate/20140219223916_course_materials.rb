class CourseMaterials < ActiveRecord::Migration
  def change
    create_table :course_materials do |t|
      t.string :name
    end
  end
end
