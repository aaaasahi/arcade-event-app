class Administrator::UsersDataController < ApplicationController
  before_action :admin_user
  def index
    @users = User.all.includes(:profile)
    @users_yesterday = User.yesterday

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "event", template: "administrator/users_data/index.html.haml"
      end
    end
  end
  
  private
    def admin_user
      redirect_to(root_url) unless current_user.administrator?
    end
end