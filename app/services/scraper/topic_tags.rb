module Scraper
    class TopicTags
        def self.create_topic_tags()
            topic_tags = self.get_topic_tags()[:data]
            db_elements = TopicTag.pluck "gql_id"
            gql_elements = topic_tags.pluck "gql_id"
            diff = gql_elements - db_elements
            to_insert = topic_tags.select{|e|diff.member? e['gql_id']}
            TopicTag.insert_all(to_insert) unless to_insert.empty? 
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