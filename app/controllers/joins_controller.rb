class JoinsController < ApplicationController
  before_action :authenticate_user!

  def show
    event = Event.find(params[:event_id])
    join_status = current_user.has_joined?(event)
    render json: { hasJoined: join_status }
  end

  def create
    event = Event.find(params[:event_id])
    event.joins.create!(user_id: current_user.id)
    render json: { status: 'ok' }
  end

  def destroy
    event = Event.find(params[:event_id])
    join = event.joins.find_by!(user_id: current_user.id)

    join.destroy!
    render json: { status: 'ok' }
  end

end