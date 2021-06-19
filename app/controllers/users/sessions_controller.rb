class Users::SessionsController < Devise::SessionsController

  def guest_sign_in
    sign_in User.guest
    redirect_to root_path, notice: "ゲストユーザーとしてログインしました。"
  end

  protected

  def reject_user
    @user = User.find(params[:id])
    if @user 
      if @user.valid_password?(params[:user][:password]) &&  (@user.is_valid == true)
        redirect_to new_user_registration
      end
    end
  end
end