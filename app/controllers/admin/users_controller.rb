class Admin::UsersController < Admin::ApplicationController
  before_action :set_user, only: %i[edit update destroy]

  def index
    @users = User.order(:id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: t('.create.success')
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: t('.update.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user == @users
      flash.now[:alert] = t('.destroy.alert.current_user')
      render :index
    elsif @user.destroy
      redirect_to action: :index
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
