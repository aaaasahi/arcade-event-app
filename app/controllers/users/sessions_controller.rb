module Users
  class SessionsController < Devise::SessionsController
    def guest_sign_in
      sign_in User.guest
      redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
    end

    protected

    def reject_user
      @user = User.find(params[:id])
      redirect_to new_user_registration if @user && (@user.valid_password?(params[:user][:password]) && (@user.is_valid == true))
    end
  end
end
