class CreateProblems < ActiveRecord::Migration[7.0]
  def change
    create_table :problems do |t|
      t.string :title
      t.integer :difficulty
      t.text :description
      t.text :constraints

      t.timestamps
    end
  end
end
