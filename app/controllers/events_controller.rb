class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @q = Event.ransack(params[:q])
    @events = @q.result(distinct: true)
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
      redirect_to events_path, notice: '作成しました'
    else
      flash.now[:error] = '作成に失敗しました'
      render :new
    end
  end

  def edit
    @event = current_user.events.find(params[:id])
  end

  def update
    @event = current_user.events.find(params[:id])
    if @event.update(event_params)
      redirect_to event_path(@event), notice: '更新しました'
    else
      flash.now[:error] = '更新に失敗しました'
      render :edit
    end
  end

  def destroy
    event = current_user.events.find(params[:id])
    event.destroy!
    redirect_to events_path, notice: '削除しました'
  end

  def search
    @q = Event.search(search_params)
    @events = @q.result(distinct: true)
  end

  private

  def event_params
    params.require(:event).permit(:name, :text, :store, :date, :eyecatch, :prefecture_id, :category_id)
  end

  def search_params
    params.require(:q).permit(:name_cont, :prefecture_id_eq,:category_id_eq)
  end
end