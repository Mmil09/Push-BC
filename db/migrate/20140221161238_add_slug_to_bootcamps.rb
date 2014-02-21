class AddSlugToBootcamps < ActiveRecord::Migration
  def change
    add_column :bootcamps, :slug, :string
    add_index :bootcamps, :slug
  end
end
