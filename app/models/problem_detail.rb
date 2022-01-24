class ProblemDetail < ApplicationRecord
  belongs_to :problem
  serialize :metaData
  serialize :hints

  def self.findOrCreate(value)
    value = Problem.find(value) if (value.is_a? String)
    problem_detail = value.problem_detail
    if problem_detail.nil?
      problem_detail = Scraper::Problems.get_problem_details(value.slug)[:data]
      similar_questions_gql = details.delete :similarQuestions

      value.create_problem_detail details.to_hash
      similar_questions_ids = Problem.where(slug: similar_questions_gql.map(&:titleSlug)).map(&:id)
      value.similarity_ids=similar_questions_ids
    end
    problem_detail
  end
end
