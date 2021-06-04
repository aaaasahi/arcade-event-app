class TagsController < ApplicationController
  def index
    @tag = Tag.find(params[:tag_id])
    @events = @tag.events.order(created_at: :desc).all
  end
end
