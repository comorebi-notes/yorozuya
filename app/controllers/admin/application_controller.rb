class Admin::ApplicationController < ApplicationController
  include Pagy::Backend

  before_action :require_login!

  protect_from_forgery with: :exception

  layout 'admin'

  def current_user
    @current_user ||= User.find_by(remember_token: User.encrypt(cookies[:user_remember_token]))
  end
  helper_method :current_user

  def logged_in?
    current_user.present?
  end
  helper_method :logged_in?

  def login(user)
    remember_token = User.new_remember_token
    cookies.permanent[:user_remember_token] = remember_token
    user.update!(remember_token: User.encrypt(remember_token))
    @current_user = user
  end

  def logout
    cookies.delete(:user_remember_token)
  end

  private

  def require_login!
    redirect_to admin_login_path unless logged_in?
  end
end
