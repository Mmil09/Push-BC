class Create < ActiveRecord::Migration
  create_table :user_bootcamps do |t|
    t.integer :bootcamp_id
    t.integer :user_id
  end
end
