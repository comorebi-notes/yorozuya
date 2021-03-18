class Admin::CreatorsController < Admin::ApplicationController
  before_action :set_new_creator, only: %i[new]
  before_action :set_creator, only: %i[show edit update destroy]
  before_action :build_creator_sites, only: %i[new edit]

  def index
    @pagy, @creators = pagy Creator.includes(:creator_sites, icon_attachment: :blob).order(:id)
  end

  def show
    @pagy, @works = pagy @creator.works.includes(work_creators: { creator: { icon_attachment: :blob } }, eye_catch_attachment: :blob).order(release_date: :desc).distinct
  end

  def new; end

  def create
    @creator = Creator.new(creator_params)
    if @creator.save
      redirect_to admin_creator_path(@creator), notice: t('admin.flash.create.success', model: Creator.model_name.human)
    else
      build_creator_sites if @creator.creator_sites.length.zero?
      render :new
    end
  end

  def edit; end

  def update
    if @creator.update(creator_params)
      @creator.icon.purge if params[:icon_destroy]
      redirect_to admin_creator_path(@creator), notice: t('admin.flash.update.success', model: Creator.model_name.human)
    else
      build_creator_sites if @creator.creator_sites.length.zero?
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
    params.require(:creator).permit(:name, :profile, :icon, creator_sites_attributes: %i[id name kind url _destroy])
  end

  def set_new_creator
    @creator = Creator.new
  end

  def set_creator
    @creator = Creator.find(params[:id])
  end

  def build_creator_sites
    @creator.creator_sites.build(kind: nil)
  end
end
