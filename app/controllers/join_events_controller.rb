class JoinEventsController < ApplicationController
  before_action :authenticate_user!
  PER_PAGE = 5

  def index
    @events = current_user.join_events.includes(:tags, :tagmaps).with_attached_eyecatch.page(params[:page]).per(PER_PAGE)
  end
end
