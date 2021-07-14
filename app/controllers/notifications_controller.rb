class NotificationsController < ApplicationController
  before_action :authenticate_user!
  PER_PAGE = 5

  def index
    @notifications = current_user.passive_notifications.page(params[:page]).per(PER_PAGE)
  end

  def update
    notification = Notification.find(params[:id]) 
    if notification.update(checked: true) 
      redirect_to notifications_path
    end
  end
end