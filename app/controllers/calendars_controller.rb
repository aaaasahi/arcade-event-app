class CalendarsController < ApplicationController
  EVENT_LIMIT = 100
  def index
    @events = Event.limit(EVENT_LIMIT)
  end
end
