require 'MyGQLiClient'
require 'net/http'
module Scraper
    class Problem
        def self.get_problems(skip=0,limit=50)
            client = MyGQLiClient.new("https://leetcode.com/graphql/", validate_query: false)
            query = <<-QUERY
            query problemsetQuestionList($categorySlug: String, $limit: Int, $skip: Int, $filters: QuestionListFilterInput) {
                problemsetQuestionList: questionList(
                    categorySlug: $categorySlug
                    limit: $limit
                    skip: $skip
                    filters: $filters
                    ) {
                    total: totalNum
                    questions: data {
                        acRate
                        difficulty
                        freqBar
                        frontendQuestionId: questionFrontendId
                        isFavor
                        paidOnly: isPaidOnly
                        status
                        title
                        titleSlug
                        topicTags {
                            name
                            id
                            slug
                            }
                        hasSolution
                        hasVideoSolution
                    }
                }
            }
            QUERY
            client.execute!({
                query: query,
                variables: {
                    categorySlug:"",
                    skip:skip,
                    limit:limit,
                    filters:{}
                }
            })
        end
        def self.get_all_problems_definitions
            url = URI.parse('https://leetcode.com/api/problems/all/')
            res = Net::HTTP.start(url.host, url.port,:use_ssl=>true) do |http|
                http.get(url.path) 
            end
            JSON.parse(res.body)["stat_status_pairs"]
        end
    end
end