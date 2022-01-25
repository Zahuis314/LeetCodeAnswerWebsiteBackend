json.problems do
    json.array! @problems, partial: "api/problems/problem_index", as: :problem
end
json.page_data do
    json.total_rows @page_props[:total_rows]
    json.per_page @page_props[:per_page]
end