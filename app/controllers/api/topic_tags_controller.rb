class Api::TopicTagsController < ApplicationController
  skip_before_action :verify_authenticity_token
  
    # GET /api/topic_tags.json
  def index
    @topic_tags = TopicTag.all.map{|tt| {value: tt.id, text: tt.name}}
    render json: @topic_tags.to_json
  end
end
  