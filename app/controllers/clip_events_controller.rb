class ClipEventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = current_user.clip_events
  end
end