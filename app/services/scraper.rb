require 'MyGQLiClient'
require 'selenium-webdriver'
module Scraper

    class Topics
        def self.get_topics()
            client = MyGQLiClient.new("https://leetcode.com/graphql/", validate_query: false)
            query = <<-QUERY
            query questionTags {
                questionTopicTags {
                    edges {
                        node {
                            name
                            translatedName
                            slug
                        }
                    }
                }
            }
            QUERY
            result = client.execute!({
                query: query
            })
            return {
                data: result.data.questionTopicTags.edges.map(&:node),
                error: result.errors
            }
        end
    end

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
                    questionId
                    questionFrontendId
                    title
                    titleSlug
                    content
                    isPaidOnly
                    difficulty
                    likes
                    dislikes
                    similarQuestions
                    categoryTitle
                    topicTags {
                        name
                        slug
                    }
                    stats
                    hints
                    solution {
                        id
                        canSeeDetail
                        paidOnly
                        hasVideoSolution
                        paidOnlyVideo
                    }
                    metaData
                    challengeQuestion {
                        id
                        date
                        incompleteChallengeCount
                        streakCount
                        type
                        __typename
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