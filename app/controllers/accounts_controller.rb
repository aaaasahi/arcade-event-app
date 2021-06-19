class AccountsController < ApplicationController

  def show
    @user = User.find(params[:id])
    if @user == current_user
      redirect_to profile_path
    end

    # DM処理
    # Entryに記録するために押したユーザー探す
    @current_entry = Entry.where(user_id: current_user.id)
    # 押されたユーザー
    @another_entry = Entry.where(user_id: @user.id)
    # ログインユーザーじゃない
    unless @user.id == current_user.id
      @current_entry.each do |current|
        @another_entry.each do |another|
          # id同じ = 同部屋 存在する場合
          if current.room_id == another.room_id
            @is_room = true
            @room_id = current.room_id
          end
        end
      end
      # ルームが存在しない場合は新規作成
      unless @is_room
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def unsubscribe
    @user = User.find(params[:id])
  end

  def withdrawal
    @user = User.find(params[:id])
    @user.update(is_valid: false)
    reset_session
    flash[:notice] = "退会処理を実行しました。"
    redirect_to root_path
  end

end