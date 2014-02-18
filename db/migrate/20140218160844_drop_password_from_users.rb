class DropPasswordFromUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :password
    end
  end
end
