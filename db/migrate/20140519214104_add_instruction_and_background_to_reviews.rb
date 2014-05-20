class AddInstructionAndBackgroundToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :instruction, :text
    add_column :reviews, :background, :text
  end
end
