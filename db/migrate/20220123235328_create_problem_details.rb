class CreateProblemDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :problem_details do |t|
      t.text :content, null: false
      t.text :solution
      t.text :hints
      t.text :metaData
      t.integer :totalAccepted
      t.integer :totalSubmission
      t.integer :like
      t.integer :dislikes
      t.references :problem, index: {:unique=>true}, null: false, foreign_key: true

      t.timestamps
    end
  end
end
