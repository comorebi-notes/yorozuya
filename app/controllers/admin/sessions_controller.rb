class Admin::SessionsController < Admin::ApplicationController
  skip_before_action :require_login!, only: %i[new create]
  before_action :set_user, only: :create

  def new; end

  def create
    if @user.authenticate(session_params[:password])
      login(@user)
      redirect_to admin_root_path, notice: t('.login')
    else
      flash.now[:alert] = t('.failed')
      render :new
    end
  end

  def destroy
    logout
    redirect_to admin_login_path, notice: t('.logout')
  end

  private

  def session_params
    params.permit(:screen_name, :password)
  end

  def set_user
    @user = User.find_by(screen_name: session_params[:screen_name])
    return if @user.present?

    flash.now[:alert] = t('.failed')
    render :new
  end

  def login(user)
    remember_token = User.new_remember_token
    cookies.permanent[:user_remember_token] = remember_token
    user.update!(remember_token: User.encrypt(remember_token))
    @current_user = user
  end

  def logout
    cookies.delete(:user_remember_token)
  end
end
