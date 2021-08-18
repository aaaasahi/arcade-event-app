class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    message = Message.new(message_params)
    message.user_id = current_user.id
    room = message.room
    if message.save
      another_room = Entry.where(room_id: room.id).where.not(user_id: current_user.id)
      theid = another_room.find_by(room_id: room.id)
      notification = current_user.active_notifications.new(
        room_id: room.id,
        message_id: message.id,
        visited_id: theid.user_id,
        visitor_id: current_user.id,
        action: 'dm'
      )
      notification.checked = true if notification.visitor_id == notification.visited_id
      notification.save if notification.valid?

      redirect_to room_path(message.room)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def message_params
    params.require(:message).permit(:room_id, :body)
  end
end
