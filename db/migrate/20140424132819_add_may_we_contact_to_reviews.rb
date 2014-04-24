class AddMayWeContactToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :may_we_contact, :boolean
  end
end
