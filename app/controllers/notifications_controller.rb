class NotificationsController < ApplicationController
  before_action :authenticate_user!
  PER_PAGE = 5

  def index
    @notifications = current_user.passive_notifications.includes(:event, :room, :visitor).page(params[:page]).per(PER_PAGE)
  end

  def update
    notification = Notification.find(params[:id])
    redirect_to notifications_path if notification.update(checked: true)
  end
end
