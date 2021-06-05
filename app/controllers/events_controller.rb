class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_search, only: [:search]
  PER_PAGE = 5
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
    tag_list = params[:event][:tag_name].split(nil)
    if @event.save
      @event.save_event_tag(tag_list)
      redirect_to events_path, notice: '作成しました'
    else
      flash.now[:error] = '作成に失敗しました'
      render :new
    end
  end

  def edit
    @event = current_user.events.find(params[:id])
    @tag_list = @event.tags.pluck(:tag_name).join(",")
  end

  def update
    @event = current_user.events.find(params[:id])
    tag_list = params[:event][:tag_name].split(nil)
    if @event.update(event_params)
      @event.save_event_tag(tag_list)
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
    @tag_lists = Tag.all

    if params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      @events = @tag.events.order(created_at: :desc).page(params[:page]).per(PER_PAGE)
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :text, :store, :date, :eyecatch, :prefecture_id, :category_id)
  end

  def set_search
    @q = Event.ransack(params[:q])
    @events = @q.result(distinct: true).page(params[:page]).per(PER_PAGE)
  end
end