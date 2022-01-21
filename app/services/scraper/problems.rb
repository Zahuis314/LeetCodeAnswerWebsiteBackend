module Scraper
    class Problems
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
                        questionFrontendId
                        questionId
                        isPaidOnly
                        title
                        titleSlug
                    }
                }
            }
            QUERY
            result = client.execute!({
                query: query,
                variables: {
                    categorySlug:"",
                    skip:skip,
                    limit:limit,
                    filters:{}
                }
            })
            return {
                data: {
                    total: result.data.problemsetQuestionList.total,#["edges"].map(&:node),
                    questions: result.data.problemsetQuestionList.questions
                },
                error: result.errors
            }
        end
        
        def self.get_problem_details(slug)
            client = MyGQLiClient.new("https://leetcode.com/graphql/", validate_query: false)
            query = <<-QUERY
            query questionData($titleSlug: String!) {
                question(titleSlug: $titleSlug) {
                    content
                    likes
                    dislikes
                    stats
                    hints
                    solution {
                        content
                    }
                    metaData
                    similarQuestions
                    topicTags {
                        gql_id :id
                    }
                }
            }
            QUERY
            result = client.execute!({
                query: query,
                variables: {
                    titleSlug: slug
                },
                operationName: "questionData"
            })
            result.data.question.similarQuestions = JSON.parse(result.data.question.similarQuestions).map{|r| r.except "translatedTitle"}
            result.data.question.stats = JSON.parse(result.data.question.stats).except "totalAccepted","totalSubmission"
            result.data.question.metaData = JSON.parse(result.data.question.metaData)#.except "totalAccepted","totalSubmission"
            return {
                data: result.data.question,
                error: result.errors
            }
        end
    end
end