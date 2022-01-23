class ModifyProblemsTable < ActiveRecord::Migration[7.0]
  def change
    change_table :problems do |t|
      t.string :title_slug, null: false, index: { unique: true}
      t.boolean :is_paid_only, null: false, default: false
      t.string :question_id, null: false, index: { unique: true}
      t.string :question_frontend_id, null: false, index: { unique: true}
      t.float :ac_rate, precision: 10
    end
    remove_columns :problems, :description, :constraints, type: :string
    add_index :problems, :title, unique: true
    change_column_null :problems, :title, false
  end
end
