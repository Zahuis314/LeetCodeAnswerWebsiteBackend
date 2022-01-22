class CreateJoinTableProblemTopicTag < ActiveRecord::Migration[7.0]
  def change
    create_join_table :problems, :topic_tags do |t|
      t.index [:problem_id, :topic_tag_id]
      t.index [:topic_tag_id, :problem_id]
    end
  end
end
