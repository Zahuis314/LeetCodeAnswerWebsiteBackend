class AddIndexToProblems < ActiveRecord::Migration[7.0]
  def change
    add_index :problems, :difficulty
  end
end
