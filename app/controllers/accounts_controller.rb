class AccountsController < ApplicationController
  def show
    @user = User.find(params[:id])

    redirect_to profile_path if @user == current_user

    # DM
    if user_signed_in?
      @current_entry = Entry.where(user_id: current_user.id)
      @another_entry = Entry.where(user_id: @user.id)
      unless @user.id == current_user.id
        @current_entry.each do |current|
          @another_entry.each do |another|
            if current.room_id == another.room_id
              @is_room = true
              @room_id = current.room_id
            end
          end
        end
        unless @is_room
          @room = Room.new
          @entry = Entry.new
        end
      end
    end
  rescue StandardError
    redirect_to root_path, notice: '存在しないユーザーです。'
  end

  def unsubscribe
    @user = User.find(params[:id])
  end

  def withdrawal
    @user = User.find(params[:id])
    if @user.email == 'guest@example.com'
      flash[:error] = 'ゲストユーザーは退会できません'
      redirect_to root_path
    else 
    @user.update(is_valid: false)
    reset_session
    flash[:notice] = '退会処理を実行しました。'
    redirect_to root_path
    end
  end
end
