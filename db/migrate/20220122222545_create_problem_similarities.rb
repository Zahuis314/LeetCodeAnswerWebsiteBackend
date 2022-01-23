class CreateProblemSimilarities < ActiveRecord::Migration[7.0]
  def change
    create_table :problem_similarities do |t|
      t.integer :source_id
      t.integer :target_id
      
      t.timestamps
    end
    add_index(:problem_similarities, [:source_id, :target_id], :unique => true)
    add_index(:problem_similarities, [:target_id, :source_id], :unique => true)
  end
end
