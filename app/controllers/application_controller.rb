class ApplicationController < ActionController::Base
  before_action :set_locale
  def current_user
    ActiveDecorator::Decorator.instance.decorate(super) if super.present?
    super
  end

  def default_url_options
    { locale: I18n.locale }
  end


  def after_sign_in_path_for(resource)
    if current_user.administrator?
      administrator_admins_path 
    else 
      root_path
    end
  end 

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

end
