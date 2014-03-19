class CreateResponse < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.text :response
      t.integer :review_id
      t.integer :bc_admin_id
      t.timestamps
    end
  end
end
