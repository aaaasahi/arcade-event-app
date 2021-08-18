class RoomsController < ApplicationController
  before_action :authenticate_user!
  def create
    room = Room.create
    current_entry = Entry.create(user_id: current_user.id, room_id: room.id)
    another_entry = Entry.create(user_id: params[:entry][:user_id], room_id: room.id)
    redirect_to room_path(room)
  end

  def index
    current_entries = current_user.entries
    my_room_id = []
    current_entries.includes(:room).each do |entry|
      my_room_id << entry.room.id
    end
    @another_entries = Entry.includes(:room, user: [profile: { avatar_attachment: :blob }]).where(room_id: my_room_id).where.not(user_id: current_user.id)
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages.includes(:user)
    @message = Message.new
    @entries = @room.entries
    @another = @entries.where.not(user_id: current_user.id).first
  rescue StandardError
    redirect_to rooms_path, notice: '存在しない部屋です。'
  end
end
