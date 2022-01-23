class TopicTag < ApplicationRecord
  validates_presence_of :gql_id, :name, :slug
  validates_uniqueness_of :gql_id, :name, :slug
  has_and_belongs_to_many :problems
end
