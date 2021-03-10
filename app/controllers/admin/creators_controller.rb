class Admin::CreatorsController < Admin::ApplicationController
  before_action :set_creator, only: %i[show edit update destroy]

  def index; end

  def show; end

  def new; end

  def create
    @creator = Creator.new(creator_params)
    if @creator.save
      redirect_to admin_creator_path(@creator), notice: t('admin.flash.create.success', model: Creator.model_name.human)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @creator.update(creator_params)
      redirect_to admin_creator_path(@creator), notice: t('admin.flash.update.success', model: Creator.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    if @creator.destroy
      redirect_to admin_creators_path, notice: t('admin.flash.destroy.success', model: Creator.model_name.human)
    else
      redirect_back fallback_location: admin_creators_path, notice: t('admin.flash.create.success', model: Creator.model_name.human)
    end
  end

  private

  def creator_params
    params.require(:creator).permit(:name, :profile, :icon)
  end

  def set_creator
    @creator = Creator.find(params[:id])
  end
end
