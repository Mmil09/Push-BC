 class CreateBootcamp < ActiveRecord::Migration
  def change
    create_table :bootcamps do |t|
      t.string :name
      t.text :description
      t.string :format
      t.integer :length
      t.string :class_size
      t.string :sessions
      t.string :hours
      t.string :minimum_skill
      t.boolean :placement_test
      t.string :prep_work
      t.float :cost
      t.string :refund
      t.string :financing
      t.integer :deposit
      t.string :payment_plan
      t.boolean :job_assistance
      t.boolean :housing
      t.boolean :visa_assistance
      t.string :email
      t.string :phone
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.string :website

    end
  end
end
