class CreateTopicTags < ActiveRecord::Migration[7.0]
  def change
    create_table :topic_tags do |t|
      t.string :gql_id, null: false, index: { unique: true}
      t.string :name, null: false, index: { unique: true}
      t.string :slug, null: false, index: { unique: true}

      t.timestamps
    end
  end
end
