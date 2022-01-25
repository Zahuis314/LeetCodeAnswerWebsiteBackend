class ChangeColumnNameInProblemDetails < ActiveRecord::Migration[7.0]
  def change
    rename_column :problem_details, :like, :likes
  end
end
