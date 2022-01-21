module Scraper
    class TopicTags
        def self.create_topic_tags()
            topic_tags = self.get_topic_tags()
            TopicTag.insert_all(topic_tags[:data])
        end
        def self.get_topic_tags()
            client = MyGQLiClient.new("https://leetcode.com/graphql/", validate_query: false)
            query = <<-QUERY
            query questionTags {
                questionTopicTags {
                    edges {
                        node {
                            gql_id :id
                            name
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
end