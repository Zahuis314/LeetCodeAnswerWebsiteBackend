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
end