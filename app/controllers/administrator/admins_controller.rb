class Administrator::AdminsController < ApplicationController
  before_action :admin_user
  def index
    @users = User.all 
    @users_week = User.week
    @users_yesterday = User.yesterday


    @events = Event.all
    @events_week = Event.week
    @events_yesterday = Event.yesterday


    @music = Event.where(category_id: 1).count
    @video = Event.where(category_id: 2).count
    @card = Event.where(category_id: 3).count
    @other = Event.where(category_id: 4).count
  end
  
  private
    def admin_user
      redirect_to(root_url) unless current_user.administrator?
    end
end