class AccountsController < ApplicationController

  def show
    @user = User.find(params[:id])
    if @user == current_user
      redirect_to profile_path
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