require 'gqli'

class MyGQLiClient < GQLi::Client
    def execute!(dict)
        http_response = request.post(@url, params: @params, json: dict)
        fail "Error: #{http_response.reason}\nBody: #{http_response.body}" if http_response.status >= 300
        parsed_response = JSON.parse(http_response.to_s)
        data = parsed_response['data']
        errors = parsed_response['errors']
        http_response
        GQLi::Response.new(data, errors, dict[:query])
    end
end