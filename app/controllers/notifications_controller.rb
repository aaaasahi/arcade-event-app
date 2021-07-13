class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.passive_notifications
  end

  def update
    notification = Notification.find(params[:id]) 
    if notification.update(checked: true) 
      redirect_to notifications_path
    end
  end
end