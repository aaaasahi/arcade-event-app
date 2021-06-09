class JoinsController < ApplicationController
  before_action :authenticate_user!

  def create
    event = Event.find(params[:event_id])
    event.joins.create!(user_id: current_user.id)
    redirect_to event_path(event)
  end

end