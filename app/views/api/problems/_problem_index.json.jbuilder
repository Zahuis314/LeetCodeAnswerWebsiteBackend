json.extract! problem, :question_frontend_id, :title, :difficulty, :is_paid_only, :ac_rate, :slug
json.topic_tags do
    json.array! problem.topic_tags, :name
end
