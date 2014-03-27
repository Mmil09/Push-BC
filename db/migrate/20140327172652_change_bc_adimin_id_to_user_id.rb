class ChangeBcAdiminIdToUserId < ActiveRecord::Migration
  def change
  	rename_column :replies, :bc_admin_id, :user_id 
  end
end
