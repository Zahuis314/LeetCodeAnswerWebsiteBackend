class ChangeColumnNameInProblem < ActiveRecord::Migration[7.0]
  def change
    rename_column :problems, :title_slug, :slug
  end
end
