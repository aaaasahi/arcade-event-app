class JoinsController < ApplicationController
  before_action :authenticate_user!

  def create
    event = Event.find(params[:event_id])
    event.joins.create!(user_id: current_user.id)
    redirect_to event_path(event)
  end

  def destroy
    event = Event.find(params[:event_id])
    join = event.joins.find_by!(user_id: current_user.id)

    join.destroy!
    redirect_to event_path(event)
  end

end