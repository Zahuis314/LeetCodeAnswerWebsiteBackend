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
  def self.with_topic_tags(values)
    prob_ids = includes(:topic_tags).where(topic_tags: { id: values.pop }).ids if values.count > 0
    while values.count > 0 do
      prob_ids = includes(:topic_tags).where(id: prob_ids).where(topic_tags: { id:values.pop }).ids
    end
    where(id: prob_ids)
  end
end
