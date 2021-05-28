class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = current_user.events.build
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to events_path, notice: '保存できました'
    else
      flash.now[:error] = '保存に失敗しました'
      render :new
    end
  end


  private

  def event_params
    params.require(:event).permit(:name, :text, :store, :date, :eyecatch)
  end
end