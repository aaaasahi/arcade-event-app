module Api
  class ClipsController < ApplicationController
    before_action :authenticate_user!
  
    def show
      event = Event.find(params[:event_id])
      clip_status = current_user.has_clipped?(event)
      render json: { hasClipped: clip_status }
    end
  
    def create
      event = Event.find(params[:event_id])
      event.clips.create!(user_id: current_user.id)
      render json: { status: 'ok' }
    end
  
    def destroy
      event = Event.find(params[:event_id])
      clip = event.clips.find_by!(user_id: current_user.id)
  
      clip.destroy!
      render json: { status: 'ok' }
    end
  end
end
