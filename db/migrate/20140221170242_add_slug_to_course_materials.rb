class AddSlugToCourseMaterials < ActiveRecord::Migration
  def change
    add_column :course_materials, :slug, :string
    add_index :course_materials, :slug
  end
end
