class Admin::UsersController < Admin::ApplicationController
  before_action :set_user, only: %i[edit update destroy]

  def index
    @pagy, @users = pagy User.order(:id)
  end

  def new; end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: t('admin.flash.create.success', model: User.model_name.human)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: t('admin.flash.update.success', model: User.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user == @user
      flash.now[:alert] = t('.destroy.alert.current_user')
      render :index
    elsif @user.destroy
      redirect_to admin_users_path, notice: t('admin.flash.destroy.success', model: User.model_name.human)
    else
      render :index
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :screen_name, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
