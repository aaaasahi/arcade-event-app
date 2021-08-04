class ClipEventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = current_user.clip_events.includes(:tags, :tagmaps).with_attached_eyecatch
  end
end