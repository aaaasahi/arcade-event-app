class JoinEventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = current_user.join_events
  end
end