class Change < ActiveRecord::Migration
  def change
  	rename_table :users_tables, :users
  end
end
