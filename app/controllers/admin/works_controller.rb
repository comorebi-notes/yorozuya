class Admin::WorksController < Admin::ApplicationController
  before_action :set_new_work, only: %i[new]
  before_action :set_work, only: %i[show edit update destroy]
  before_action :build_work_creators, only: %i[new edit]

  def index
    @pagy, @works = pagy Work.includes(work_creators: { creator: { icon_attachment: :blob } }, eye_catch_attachment: :blob).order(release_date: :desc)
  end

  def show; end

  def new; end

  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to admin_work_path(@work), notice: t('admin.flash.create.success', model: Work.model_name.human)
    else
      build_work_creators if @work.work_creators.length.zero?
      render :new
    end
  end

  def edit; end

  def update
    if @work.update(work_params)
      @work.eye_catch.purge if params[:icon_destroy]
      redirect_to admin_work_path(@work), notice: t('admin.flash.update.success', model: Work.model_name.human)
    else
      build_work_creators if @work.work_creators.length.zero?
      render :edit
    end
  end

  def destroy
    if @work.destroy
      redirect_to admin_works_path, notice: t('admin.flash.destroy.success', model: Work.model_name.human)
    else
      redirect_back fallback_location: admin_works_path, notice: t('admin.flash.create.success', model: Work.model_name.human)
    end
  end

  private

  def work_params
    params.require(:work)
          .permit(:title, :status, :slug, :release_date, :description, :content, :eye_catch, :work_id,
                  work_creators_attributes: %i[id guest role xorder creator_id name _destroy])
  end

  def set_new_work
    @work = Work.new
  end

  def set_work
    @work = Work.find_by!(slug: params[:slug])
  end

  def build_work_creators
    @work.work_creators.build(role: nil)
  end
end
