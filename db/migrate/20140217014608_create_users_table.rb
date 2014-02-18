class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users_tables do |t|
    	t.string :username
    	t.string :password
    	t.string :type
    	t.string :email
    	t.timestamps

    end
  end
end
