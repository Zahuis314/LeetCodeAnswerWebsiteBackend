module Scraper
    class Problems
        def self.create_problems()
            problems = self.get_problems(0,-1)[:data][:questions]
            db_elements = Problem.pluck "question_id"
            gql_elements = problems.pluck "question_id"
            diff = gql_elements - db_elements
            to_insert = problems.select{|e|diff.member? e['question_id']}
            to_insert.each do |problem|
                topic_tag_array = problem.delete :topicTags
                topic_tags_gql_ids = topic_tag_array.pluck :gql_id
                topic_tags_ids = TopicTag.where(:gql_id => topic_tags_gql_ids).ids
                Problem.insert(problem)
                Problem.last.topic_tag_ids = topic_tags_ids
            end
        end
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
                        ac_rate: acRate
                        difficulty
                        question_frontend_id: questionFrontendId
                        question_id: questionId
                        is_paid_only: isPaidOnly
                        title
                        slug: titleSlug
                        topicTags {
                            gql_id :id
                        }
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