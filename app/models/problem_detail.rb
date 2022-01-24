class ProblemDetail < ApplicationRecord
  belongs_to :problem
  serialize :metaData
  serialize :hints

  def self.findOrCreate(value)
    value = Problem.find(value) if (value.is_a? String)
    problem_detail = value.problem_detail
    if problem_detail.nil?
      problem_detail_gql = Scraper::Problems.get_problem_details(value.slug)[:data]
      similar_questions = problem_detail_gql.delete :similarQuestions

      problem_detail = value.create_problem_detail problem_detail_gql.to_hash
      similar_questions_ids = Problem.where(slug: similar_questions.map(&:titleSlug)).map(&:id)
      value.similarity_ids=similar_questions_ids
    end
    problem_detail
  end
end
