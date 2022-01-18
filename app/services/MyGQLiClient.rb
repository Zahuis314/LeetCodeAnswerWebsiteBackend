require 'gqli'

class MyGQLiClient < GQLi::Client
    def execute!(query,variables=nil)
        http_response = request.post(@url, params: @params, json: { query: query,variables: variables })
        fail "Error: #{http_response.reason}\nBody: #{http_response.body}" if http_response.status >= 300
        parsed_response = JSON.parse(http_response.to_s)
        data = parsed_response['data']
        errors = parsed_response['errors']
        http_response
        GQLi::Response.new(data, errors, query)
    end
end