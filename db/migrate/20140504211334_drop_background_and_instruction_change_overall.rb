class DropBackgroundAndInstructionChangeOverall < ActiveRecord::Migration
  def down
    remove_column :reviews, :background
    remove_column :reviews, :instruction
  end
end
