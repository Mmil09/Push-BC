class AddForeignKeysToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :user_id, :integer
    add_column :reviews, :bootcamp_id, :integer
  end
end
