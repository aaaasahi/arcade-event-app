class ClipsController < ApplicationController
  before_action :authenticate_user!

  def create
    event = Event.find(params[:event_id])
    event.clips.create!(user_id: current_user.id)
    redirect_to event_path(event)
  end

  def destroy
    event = Event.find(params[:event_id])
    clip = event.clips.find_by!(user_id: current_user.id)

    clip.destroy!
    redirect_to event_path(event)
  end
end