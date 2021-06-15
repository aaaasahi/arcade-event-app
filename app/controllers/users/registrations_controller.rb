class  Users::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_normal_user, only: [:destroy, :update]

  protected

  def ensure_normal_user
    if resource.email == "guest@example.com"
      flash[:error] = "ゲストユーザーの更新・削除はできません。"
      redirect_back(fallback_location: root_path)
    end
  end

  def update_resource(resource, params)
    resource.update_without_current_password(params)
  end
end