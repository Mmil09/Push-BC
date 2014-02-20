class CreateBootcampMaterials < ActiveRecord::Migration
  def change
    create_table :bootcamp_materials do |t|
      t.integer :bootcamp_id
      t.integer :material_id
    end
  end
end
