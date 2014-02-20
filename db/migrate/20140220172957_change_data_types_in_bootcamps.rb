class ChangeDataTypesInBootcamps < ActiveRecord::Migration
  def up
    change_column :bootcamps, :cost, :string
    change_column :bootcamps, :deposit, :string
    change_column :bootcamps, :length, :string
  end

  def down
    change_column :bootcamps, :cost, :integer
    change_column :bootcamps, :deposit, :integer
    change_column :bootcamps, :length, :integer
  end
end
