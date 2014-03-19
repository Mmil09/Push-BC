class RenameRequests < ActiveRecord::Migration
  def change
    rename_table :responses, :replies
  end
end
