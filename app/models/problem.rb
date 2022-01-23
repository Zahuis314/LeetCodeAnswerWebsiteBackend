class Problem < ApplicationRecord
  enum difficulty: {
    Easy: 1,
    Medium: 2,
    Hard: 3
  }, _prefix: true
  validates_presence_of :title, :title_slug, :is_paid_only, :question_id, :question_frontend_id
  validates_uniqueness_of :title, :title_slug, :question_id, :question_frontend_id
  has_and_belongs_to_many :topic_tags

  has_and_belongs_to_many :similarities,
                          class_name: 'Problem',
                          join_table: :problem_similarities,
                          foreign_key: :source_id,
                          association_foreign_key: :target_id
end
